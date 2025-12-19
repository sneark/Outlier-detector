import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/main_view_model.dart';
import '../../../../core/widgets/loader_view.dart';
import 'result_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  late final MainViewModel _viewModel; 

  @override
  void initState() {
    super.initState();
    _viewModel = context.read<MainViewModel>();
    _viewModel.addListener(_onViewModelChange);
  }
  
  void _onViewModelChange() {
    if (!mounted) return;

    if (_viewModel.showResult) {
      _viewModel.resetNavigation(); 
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) => ResultPage(result: _viewModel.result),
        ),
      );
    }
  }

  @override
  void dispose() {
    _viewModel.removeListener(_onViewModelChange);
    
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: const Color(0xFFF2F2F7),
        body: Stack(
          children: [
            CustomScrollView(
              slivers: [
                const SliverAppBar(
                  title: Text("Detektor", style: TextStyle(color: Colors.black)),
                  centerTitle: true,
                  pinned: true,
                  backgroundColor: Color(0xFFF2F2F7),
                  surfaceTintColor: Colors.transparent,
                ),
                SliverPadding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
                  sliver: SliverToBoxAdapter(
                    child: Column(
                      children: [
                        _buildInputCard(context),
                        const SizedBox(height: 24),
                        _buildSearchButton(context),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Selector<MainViewModel, bool>(
              selector: (_, vm) => vm.isLoading,
              builder: (_, isLoading, __) {
                if (!isLoading) return const SizedBox.shrink();
                return const Positioned.fill(child: LoaderView());
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInputCard(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextField(
            key: const Key('inputField'),
            onChanged: (val) => context.read<MainViewModel>().updateEntryData(val),
            decoration: const InputDecoration(
              hintText: 'Wprowadź liczby (np. 5,3,18)',
              border: InputBorder.none,
              contentPadding: EdgeInsets.all(16),
            ),
            minLines: 3,
            maxLines: 8,
            keyboardType: TextInputType.text, 
            autocorrect: false,
            enableSuggestions: false,
            textInputAction: TextInputAction.done, 
            style: const TextStyle(fontSize: 17),
          ),
          
          Selector<MainViewModel, String?>(
            selector: (_, vm) => vm.errorMessage,
            builder: (_, errorMessage, __) {
              return AnimatedSize(
                duration: const Duration(milliseconds: 300),
                curve: Curves.fastOutSlowIn,
                alignment: Alignment.topCenter,
                child: errorMessage == null
                    ? const SizedBox.shrink()
                    : Container(
                        width: double.infinity,
                        color: Colors.white,
                        padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                        child: Text(
                          errorMessage,
                          style: TextStyle(
                            color: Colors.red[400],
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSearchButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        key: const Key('searchButton'),
        onPressed: () {
            FocusScope.of(context).unfocus(); 
            context.read<MainViewModel>().findOutlier();
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 0,
        ),
        child: const Text(
          'Wyszukaj',
          style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}