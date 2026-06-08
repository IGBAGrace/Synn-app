import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import '../theme/app_theme.dart';

// ── DATA MODEL ──────────────────────────────────────────────
class Product {
  final String id;
  final String name;
  final String category;
  final String subcategory;
  final String description;
  final int rseScore;
  final List<String> tags;
  final String imageUrl;
  final String catalogUrl;

  const Product({
    required this.id,
    required this.name,
    required this.category,
    required this.subcategory,
    required this.description,
    required this.rseScore,
    required this.tags,
    required this.imageUrl,
    required this.catalogUrl,
  });
}

const List<Product> _allProducts = [
  Product(id: '1', name: 'Gourde inox 500ml', category: 'Boisson', subcategory: 'Gourde', description: 'Gourde isotherme en inox recyclé, personnalisable par gravure laser.', rseScore: 5, tags: ['Zéro déchet', 'Recyclé'], imageUrl: 'https://images.unsplash.com/photo-1602143407151-7111542de6e8?w=400', catalogUrl: 'https://selection-by-synneo.fr/categorie/17-3833249-gourde-bouteille-publicitaire-goodies-personnalise'),
  Product(id: '2', name: 'Tote bag coton bio', category: 'Bagagerie', subcategory: 'Sac à main', description: 'Tote bag en coton biologique certifié GOTS, sérigraphie jusqu\'à 4 couleurs.', rseScore: 5, tags: ['Bio', 'France'], imageUrl: 'https://images.unsplash.com/photo-1597348989645-4f5cd79e02d5?w=400', catalogUrl: 'https://selection-by-synneo.fr/categorie/57-3833378-sacs-totebag-publicitaire-goodies-personnalise'),
  Product(id: '3', name: 'Carnet FSC A5', category: 'Bureau', subcategory: 'Carnet', description: 'Carnet à couverture rigide en papier certifié FSC, 80 pages lignées.', rseScore: 4, tags: ['FSC', 'Europe'], imageUrl: 'https://images.unsplash.com/photo-1517842645767-c639042777db?w=400', catalogUrl: 'https://selection-by-synneo.fr/categorie/95-3833165-carnet-publicitaire-goodies-personnalise'),
  Product(id: '4', name: 'Stylo bambou', category: 'Bureau', subcategory: 'Écriture', description: 'Stylo bille en bambou naturel avec recharge bleue. Gravure laser incluse.', rseScore: 4, tags: ['Naturel', 'Zéro déchet'], imageUrl: 'https://images.unsplash.com/photo-1583485088034-697b5bc54ccd?w=400', catalogUrl: 'https://selection-by-synneo.fr/categorie/68-3833255-stylo-publicitaire-goodies-personnalise'),
  Product(id: '5', name: 'Mug céramique 350ml', category: 'Boisson', subcategory: 'Mug', description: 'Mug en céramique fabriqué en France, personnalisation par sublimation.', rseScore: 5, tags: ['France', 'Durable'], imageUrl: 'https://images.unsplash.com/photo-1514228742587-6b1558fcca3d?w=400', catalogUrl: 'https://selection-by-synneo.fr/categorie/62-3833156-mugs-tasse-publicitaire-goodies-personnalise'),
  Product(id: '6', name: 'T-shirt coton bio', category: 'Textile', subcategory: 'T-shirt', description: 'T-shirt 100% coton biologique, certifié GOTS. Impression sérigraphie.', rseScore: 5, tags: ['Bio', 'GOTS'], imageUrl: 'https://images.unsplash.com/photo-1521572163474-6864f9cf17ab?w=400', catalogUrl: 'https://selection-by-synneo.fr/categorie/54-12473384-tshirt-publicitaire-goodies-personnalise'),
  Product(id: '7', name: 'Sac à dos recyclé', category: 'Bagagerie', subcategory: 'Sac à dos', description: 'Sac à dos 20L en polyester recyclé (bouteilles PET), compartiment laptop.', rseScore: 4, tags: ['Recyclé', 'Tech'], imageUrl: 'https://images.unsplash.com/photo-1553062407-98eeb64c6a62?w=400', catalogUrl: 'https://selection-by-synneo.fr/categorie/83-3833317-sacs-a-dos-publicitaire-goodies-personnalise'),
  Product(id: '8', name: 'Chargeur solaire', category: 'Tech', subcategory: 'Charge', description: 'Powerbank solaire 10 000mAh avec panneau photovoltaïque intégré.', rseScore: 4, tags: ['Tech', 'Éco'], imageUrl: 'https://images.unsplash.com/photo-1609091839311-d5365f9ff1c5?w=400', catalogUrl: 'https://selection-by-synneo.fr/categorie/265-4839819-cable-objet-publicitaire-goodies-personnalise'),
  Product(id: '9', name: 'Polo piqué bio', category: 'Textile', subcategory: 'Polo', description: 'Polo piqué en coton biologique, disponible en 8 coloris, broderie ou impression.', rseScore: 4, tags: ['Bio', 'Europe'], imageUrl: 'https://images.unsplash.com/photo-1586790170083-2f9ceadc732d?w=400', catalogUrl: 'https://selection-by-synneo.fr/categorie/102-3833055-polo-publicitaire-goodies-personnalise'),
  Product(id: '10', name: 'Enceinte bambou', category: 'Tech', subcategory: 'Son', description: 'Enceinte Bluetooth en bambou naturel, 8h d\'autonomie, IP54.', rseScore: 5, tags: ['Naturel', 'Tech'], imageUrl: 'https://images.unsplash.com/photo-1608043152269-423dbba4e7e1?w=400', catalogUrl: 'https://selection-by-synneo.fr/categorie/268-4839811-enceinte-objet-publicitaire-goodies-personnalise'),
  Product(id: '11', name: 'Lunchbox inox', category: 'Bureau', subcategory: 'Repas', description: 'Boîte repas hermétique en inox 304, sans BPA, 800ml. Gravure laser.', rseScore: 5, tags: ['Zéro déchet', 'Inox'], imageUrl: 'https://images.unsplash.com/photo-1490645935967-10de6ba17061?w=400', catalogUrl: 'https://selection-by-synneo.fr/categorie/950-lunchbox-publicitaire-goodies-personnalise'),
  Product(id: '12', name: 'Sweat-shirt bio', category: 'Textile', subcategory: 'Sweat', description: 'Sweat col rond en coton bio brossé, broderie poitrine ou dos.', rseScore: 4, tags: ['Bio', 'Confort'], imageUrl: 'https://images.unsplash.com/photo-1556821840-3a63f15732ce?w=400', catalogUrl: 'https://selection-by-synneo.fr/categorie/48-3833052-sweats-pulls-publicitaire-goodies-personnalise'),
];

const List<Map<String, dynamic>> _categories = [
  {'label': 'Tout', 'icon': FontAwesomeIcons.borderAll, 'filter': null},
  {'label': 'Zéro déchet', 'icon': FontAwesomeIcons.seedling, 'filter': 'Zéro déchet'},
  {'label': 'Boisson', 'icon': FontAwesomeIcons.mugHot, 'filter': 'Boisson'},
  {'label': 'Bureau', 'icon': FontAwesomeIcons.pen, 'filter': 'Bureau'},
  {'label': 'Textile', 'icon': FontAwesomeIcons.shirt, 'filter': 'Textile'},
  {'label': 'Bagagerie', 'icon': FontAwesomeIcons.bagShopping, 'filter': 'Bagagerie'},
  {'label': 'Tech', 'icon': FontAwesomeIcons.bolt, 'filter': 'Tech'},
];

// ── MAIN SCREEN ──────────────────────────────────────────────
class CatalogueScreen extends StatefulWidget {
  const CatalogueScreen({super.key});

  @override
  State<CatalogueScreen> createState() => _CatalogueScreenState();
}

class _CatalogueScreenState extends State<CatalogueScreen> {
  String? _selectedCategory;
  String _searchQuery = '';
  final TextEditingController _searchController = TextEditingController();

  List<Product> get _filteredProducts {
    return _allProducts.where((p) {
      final matchCat = _selectedCategory == null ||
          p.category == _selectedCategory ||
          p.tags.contains(_selectedCategory);
      final matchSearch = _searchQuery.isEmpty ||
          p.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          p.category.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          p.tags.any((t) => t.toLowerCase().contains(_searchQuery.toLowerCase()));
      return matchCat && matchSearch;
    }).toList();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.greyBg,
      body: CustomScrollView(
        slivers: [
          // App Bar
          SliverAppBar(
            pinned: true,
            backgroundColor: AppColors.white,
            expandedHeight: 110,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                color: AppColors.white,
                padding: const EdgeInsets.fromLTRB(20, 52, 20, 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(width: 20, height: 3, decoration: BoxDecoration(color: AppColors.teal, borderRadius: BorderRadius.circular(2))),
                        const SizedBox(width: 8),
                        const Text('NOTRE SÉLECTION', style: TextStyle(fontSize: 9, fontWeight: FontWeight.w800, color: AppColors.teal, letterSpacing: 2)),
                      ],
                    ),
                    const SizedBox(height: 4),
                    const Text('Catalogue produits', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900, color: AppColors.blue)),
                  ],
                ),
              ),
            ),
            title: const Text('Catalogue'),
            centerTitle: false,
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(52),
              child: Container(
                color: AppColors.white,
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
                child: TextField(
                  controller: _searchController,
                  onChanged: (v) => setState(() => _searchQuery = v),
                  style: const TextStyle(fontSize: 13, color: AppColors.dark),
                  decoration: InputDecoration(
                    hintText: 'Rechercher un produit...',
                    hintStyle: const TextStyle(color: AppColors.greyText, fontSize: 13),
                    prefixIcon: const Icon(Icons.search, color: AppColors.greyText, size: 18),
                    suffixIcon: _searchQuery.isNotEmpty
                        ? IconButton(
                            icon: const Icon(Icons.clear, size: 16, color: AppColors.greyText),
                            onPressed: () { _searchController.clear(); setState(() => _searchQuery = ''); },
                          )
                        : null,
                    filled: true,
                    fillColor: AppColors.greyBg,
                    contentPadding: const EdgeInsets.symmetric(vertical: 10),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(100), borderSide: BorderSide.none),
                  ),
                ),
              ),
            ),
          ),

          // Category filter chips
          SliverToBoxAdapter(
            child: Container(
              color: AppColors.white,
              child: Column(
                children: [
                  const Divider(height: 1, color: AppColors.greyBorder),
                  SizedBox(
                    height: 52,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      itemCount: _categories.length,
                      separatorBuilder: (_, __) => const SizedBox(width: 8),
                      itemBuilder: (_, i) {
                        final cat = _categories[i];
                        final isActive = _selectedCategory == cat['filter'];
                        return GestureDetector(
                          onTap: () => setState(() => _selectedCategory = cat['filter']),
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                            decoration: BoxDecoration(
                              color: isActive ? AppColors.blue : AppColors.greyBg,
                              borderRadius: BorderRadius.circular(100),
                              border: Border.all(color: isActive ? AppColors.blue : AppColors.greyBorder, width: 1.5),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                FaIcon(cat['icon'] as IconData, size: 11, color: isActive ? AppColors.teal : AppColors.greyText),
                                const SizedBox(width: 6),
                                Text(cat['label'] as String, style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: isActive ? Colors.white : AppColors.dark)),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Results count + link to full catalogue
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 14, 16, 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('${_filteredProducts.length} produits', style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: AppColors.greyText)),
                  GestureDetector(
                    onTap: () async {
                      final uri = Uri.parse('https://selection-by-synneo.fr');
                      if (await canLaunchUrl(uri)) launchUrl(uri);
                    },
                    child: const Row(
                      children: [
                        Text('Catalogue complet', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: AppColors.teal)),
                        SizedBox(width: 4),
                        Icon(Icons.open_in_new, size: 12, color: AppColors.teal),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Product Grid
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
            sliver: SliverGrid(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 0.72,
              ),
              delegate: SliverChildBuilderDelegate(
                (context, i) => _ProductCard(product: _filteredProducts[i]),
                childCount: _filteredProducts.length,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ── PRODUCT CARD ──────────────────────────────────────────────
class _ProductCard extends StatelessWidget {
  final Product product;
  const _ProductCard({required this.product});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => ProductDetailScreen(product: product))),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: AppColors.greyBorder, width: 1.5),
          boxShadow: [BoxShadow(color: AppColors.blue.withOpacity(0.05), blurRadius: 8, offset: const Offset(0, 2))],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image
            ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
              child: Stack(
                children: [
                  Image.network(
                    product.imageUrl,
                    height: 130,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => Container(
                      height: 130,
                      color: AppColors.tealLight,
                      child: const Center(child: Icon(Icons.image, color: AppColors.teal, size: 32)),
                    ),
                  ),
                  // RSE Badge
                  Positioned(
                    top: 8,
                    right: 8,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 4),
                      decoration: BoxDecoration(
                        color: AppColors.blue,
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.eco, color: AppColors.teal, size: 10),
                          const SizedBox(width: 3),
                          Text('${product.rseScore}/5', style: const TextStyle(fontSize: 9, fontWeight: FontWeight.w800, color: Colors.white)),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Content
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Category
                  Text(product.subcategory.toUpperCase(), style: const TextStyle(fontSize: 8, fontWeight: FontWeight.w700, color: AppColors.teal, letterSpacing: 1)),
                  const SizedBox(height: 3),
                  // Name
                  Text(product.name, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w800, color: AppColors.dark), maxLines: 2, overflow: TextOverflow.ellipsis),
                  const SizedBox(height: 6),
                  // Tags
                  Wrap(
                    spacing: 4,
                    runSpacing: 4,
                    children: product.tags.take(2).map((tag) => Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(color: AppColors.tealLight, borderRadius: BorderRadius.circular(100)),
                      child: Text(tag, style: const TextStyle(fontSize: 8, fontWeight: FontWeight.w600, color: AppColors.blue)),
                    )).toList(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── PRODUCT DETAIL ────────────────────────────────────────────
class ProductDetailScreen extends StatelessWidget {
  final Product product;
  const ProductDetailScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            backgroundColor: AppColors.white,
            expandedHeight: 260,
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                fit: StackFit.expand,
                children: [
                  Image.network(product.imageUrl, fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => Container(color: AppColors.tealLight,
                      child: const Center(child: Icon(Icons.image, color: AppColors.teal, size: 48)))),
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Colors.transparent, AppColors.dark.withOpacity(0.4)],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Category + RSE
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(color: AppColors.tealLight, borderRadius: BorderRadius.circular(100)),
                        child: Text(product.category.toUpperCase(), style: const TextStyle(fontSize: 9, fontWeight: FontWeight.w800, color: AppColors.blue, letterSpacing: 1)),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(color: AppColors.blue, borderRadius: BorderRadius.circular(100)),
                        child: Row(children: [
                          const Icon(Icons.eco, color: AppColors.teal, size: 12),
                          const SizedBox(width: 4),
                          Text('RSE ${product.rseScore}/5', style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w800, color: Colors.white)),
                        ]),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text(product.name, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w900, color: AppColors.blue, height: 1.2)),
                  const SizedBox(height: 12),
                  Text(product.description, style: const TextStyle(fontSize: 14, color: AppColors.greyText, height: 1.6)),
                  const SizedBox(height: 16),

                  // Tags
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: product.tags.map((tag) => Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: AppColors.tealLight,
                        borderRadius: BorderRadius.circular(100),
                        border: Border.all(color: AppColors.teal.withOpacity(0.3)),
                      ),
                      child: Text(tag, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: AppColors.blue)),
                    )).toList(),
                  ),
                  const SizedBox(height: 24),

                  // RSE Stars
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: AppColors.tealLight,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: AppColors.teal.withOpacity(0.3)),
                    ),
                    child: Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('SCORE RSE', style: TextStyle(fontSize: 9, fontWeight: FontWeight.w800, color: AppColors.blue, letterSpacing: 1)),
                            const SizedBox(height: 6),
                            Row(children: List.generate(5, (i) => Icon(
                              i < product.rseScore ? Icons.star_rounded : Icons.star_outline_rounded,
                              color: AppColors.teal, size: 22,
                            ))),
                          ],
                        ),
                        const Spacer(),
                        const Icon(Icons.eco, color: AppColors.blue, size: 32),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),

                  // CTA Buttons
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => _DevisScreen(productName: product.name))),
                      icon: const Icon(Icons.send, size: 16, color: AppColors.blue),
                      label: const Text('Demander un devis', style: TextStyle(color: AppColors.blue, fontWeight: FontWeight.w800, fontSize: 15)),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.teal,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton.icon(
                      onPressed: () async {
                        final uri = Uri.parse(product.catalogUrl);
                        if (await canLaunchUrl(uri)) launchUrl(uri);
                      },
                      icon: const Icon(Icons.open_in_new, size: 14),
                      label: const Text('Voir sur le catalogue'),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: AppColors.blue,
                        side: const BorderSide(color: AppColors.blue, width: 1.5),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ── DEVIS FORM ────────────────────────────────────────────────
class _DevisScreen extends StatefulWidget {
  final String productName;
  const _DevisScreen({required this.productName});

  @override
  State<_DevisScreen> createState() => _DevisScreenState();
}

class _DevisScreenState extends State<_DevisScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nomController = TextEditingController();
  final _societeController = TextEditingController();
  final _emailController = TextEditingController();
  final _qteController = TextEditingController();
  final _messageController = TextEditingController();
  bool _sent = false;

  @override
  void dispose() {
    _nomController.dispose();
    _societeController.dispose();
    _emailController.dispose();
    _qteController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  void _submit() async {
    if (_formKey.currentState!.validate()) {
      final subject = Uri.encodeComponent('Demande de devis — ${widget.productName}');
      final body = Uri.encodeComponent(
        'Produit : ${widget.productName}\n'
        'Nom : ${_nomController.text}\n'
        'Société : ${_societeController.text}\n'
        'Email : ${_emailController.text}\n'
        'Quantité souhaitée : ${_qteController.text}\n'
        'Message : ${_messageController.text}',
      );
      final uri = Uri.parse('mailto:commercial@synneo.fr?subject=$subject&body=$body');
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri);
        setState(() => _sent = true);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(title: const Text('Demande de devis'), backgroundColor: AppColors.white, centerTitle: false),
      body: _sent ? _SuccessView() : SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(color: AppColors.tealLight, borderRadius: BorderRadius.circular(12), border: Border.all(color: AppColors.teal.withOpacity(0.3))),
                child: Row(children: [
                  const Icon(Icons.inventory_2, color: AppColors.blue, size: 20),
                  const SizedBox(width: 12),
                  Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    const Text('Produit sélectionné', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w700, color: AppColors.greyText)),
                    Text(widget.productName, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w800, color: AppColors.blue)),
                  ])),
                ]),
              ),
              const SizedBox(height: 24),
              const Text('VOS COORDONNÉES', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w800, color: AppColors.blue, letterSpacing: 1.5)),
              const SizedBox(height: 12),
              _Field(controller: _nomController, label: 'Nom & prénom', icon: Icons.person_outline, validator: (v) => v!.isEmpty ? 'Champ requis' : null),
              const SizedBox(height: 10),
              _Field(controller: _societeController, label: 'Société', icon: Icons.business_outlined, validator: (v) => v!.isEmpty ? 'Champ requis' : null),
              const SizedBox(height: 10),
              _Field(controller: _emailController, label: 'Email professionnel', icon: Icons.email_outlined, keyboardType: TextInputType.emailAddress,
                validator: (v) => v!.isEmpty || !v.contains('@') ? 'Email invalide' : null),
              const SizedBox(height: 20),
              const Text('VOTRE PROJET', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w800, color: AppColors.blue, letterSpacing: 1.5)),
              const SizedBox(height: 12),
              _Field(controller: _qteController, label: 'Quantité souhaitée', icon: Icons.format_list_numbered, keyboardType: TextInputType.number,
                validator: (v) => v!.isEmpty ? 'Champ requis' : null),
              const SizedBox(height: 10),
              TextFormField(
                controller: _messageController,
                maxLines: 4,
                style: const TextStyle(fontSize: 13, color: AppColors.dark),
                decoration: InputDecoration(
                  labelText: 'Message (optionnel)',
                  alignLabelWithHint: true,
                  prefixIcon: const Padding(padding: EdgeInsets.only(bottom: 60), child: Icon(Icons.chat_bubble_outline, color: AppColors.greyText, size: 18)),
                  filled: true, fillColor: AppColors.greyBg,
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: AppColors.greyBorder)),
                  enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: AppColors.greyBorder)),
                  focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: AppColors.blue, width: 2)),
                ),
              ),
              const SizedBox(height: 28),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: _submit,
                  icon: const Icon(Icons.send, size: 16, color: AppColors.blue),
                  label: const Text('Envoyer ma demande', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w800, color: AppColors.blue)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.teal,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
                  ),
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}

class _Field extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final IconData icon;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;

  const _Field({required this.controller, required this.label, required this.icon, this.keyboardType, this.validator});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      validator: validator,
      style: const TextStyle(fontSize: 13, color: AppColors.dark),
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: AppColors.greyText, size: 18),
        filled: true, fillColor: AppColors.greyBg,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: AppColors.greyBorder)),
        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: AppColors.greyBorder)),
        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: AppColors.blue, width: 2)),
        errorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: Colors.red)),
      ),
    );
  }
}

class _SuccessView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 80, height: 80,
              decoration: BoxDecoration(color: AppColors.tealLight, shape: BoxShape.circle),
              child: const Icon(Icons.check_circle, color: AppColors.teal, size: 44),
            ),
            const SizedBox(height: 20),
            const Text('Demande envoyée !', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w900, color: AppColors.blue)),
            const SizedBox(height: 10),
            const Text('Un conseiller Synneo vous contactera dans les meilleurs délais.', textAlign: TextAlign.center, style: TextStyle(fontSize: 14, color: AppColors.greyText, height: 1.5)),
            const SizedBox(height: 28),
            ElevatedButton(
              onPressed: () => Navigator.popUntil(context, (r) => r.isFirst),
              style: ElevatedButton.styleFrom(backgroundColor: AppColors.teal, foregroundColor: AppColors.blue, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)), padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 14)),
              child: const Text('Retour au catalogue', style: TextStyle(fontWeight: FontWeight.w800)),
            ),
          ],
        ),
      ),
    );
  }
}
