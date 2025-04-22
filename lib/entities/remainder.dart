class Remainder {
  final int id;
  final String name;
  final String description;
  final DateTime? startTs;
  final DateTime? endTs;

  const Remainder(
    {
      required this.id, 
      required this.name, 
      required this.description, 
      this.startTs, 
      this.endTs
    }
  );

  
}