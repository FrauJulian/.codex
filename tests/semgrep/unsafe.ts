declare const db: { query(sql: string): unknown };
declare const userId: string;
declare const apiToken: string;

db.query(`SELECT * FROM users WHERE id = ${userId}`);
console.log(apiToken);
