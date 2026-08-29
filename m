Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazolkn19013079.outbound.protection.outlook.com [52.103.7.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2278C3F104C
	for <linux-input@vger.kernel.org>; Sat, 29 Aug 2026 20:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.7.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788036266; cv=fail; b=rsfJmZVNrB7enX0O9AxJSN6fG2z/QcvG/vYUF86qtbitsWLRe8SA8s7ujaCF0zLK95EVJN5ghuTag7xIjkRJ0ua/1Z24V3MsNSW7u8g+YlOHDz+1aUm8NQDzb/Og1R2rwf/6b9xvacQjxJVWMDXvV4lvTgYeoaJnRldTqMEddWw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788036266; c=relaxed/simple;
	bh=Nx+Ifhu9dch/mDK5NAgS9iDUwJbqfsgQUGBPcbtPdgI=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=COrmsoCvXhBTDl2QuRZhbI7zd63U96I6Zaz3cAWDVcaNA5Ev3MvvZChpnH+e7QbJM7NgQ8PKq2OL51kZzL3sY3vwE2zLUMX84rtdu1ZzEkZNafCv11NaKBAXCKtKO8wf5wCTiuQV70LlJ4xYcUWYX5zjWjBEtYY0B2INVzJ1ifw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=V+6jJ7bC; arc=fail smtp.client-ip=52.103.7.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="V+6jJ7bC"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BX1qtlEHb5aAR4U8Uo8OZhlDCTg05Uofg9LxgOQ8RpKAeqn4Pn8O/MfyCXgWy339H4OmcHIpRagJUFDCUuGqDPqfC14gU+cBVv/XkmBhZoe+lRM1xF0hNiOoDr8XALGGTDsse7Wc0qdfS4+8glWtVFQWD0Wum20JlseANpXH74eWtJspJBEFld3xG4mZARDFTUqrDGRM0TGxkdhzZ7Wqd/izLbRxf5IqOVs0WIt7VT8mCm3giKu883keLKcVSeULBMVjd5sh1f0nWpMX1RPeI8atTjTdrCGGwzzByiu9OHKy5g0GDl5oiqhtbGzBZAda+/c7PuJH1YCc8uMlQiqVPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Nx+Ifhu9dch/mDK5NAgS9iDUwJbqfsgQUGBPcbtPdgI=;
 b=b/VPxYqGPYOqZygOdtt/uflDGmtCnTFV5J0JZ28CXmCbXsADMpIkLlF+bHTg1JuLgCx3Z4toF7oNOc+N/7xQDUfhx+6F6K2MD9/gNCETKfzkAEodm21B91/erf8FqYvxzHBT0KvdTj8p6W0/pjKJvQkLH00OmqglhkihYs7NtyqAvf2Q0xtokfaO+I8YO1RPBSwUtHaxfdpRObbnhGxYD9NmJ/vsjdw7IK5J/JY1iTxaq2K2qroupSO7mw4nSvpnCI40sonA8MsTPzJ97ZJH7H/EorcAGUo9GBCuEMXzgVN9Oknq8iDrXEG/wvbocmzqJK0EynF/02ccbscnOdiVkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nx+Ifhu9dch/mDK5NAgS9iDUwJbqfsgQUGBPcbtPdgI=;
 b=V+6jJ7bCeHJxAmTM6Sj288aj1ZCZ0UNnVt/EWIiFSDG4kGVokRamIEM7W2GSiZfENnvT1CpNWlyaLSGLAPuRN0pTZmf6iG3pL1r6t8rE+N6zgMDx+D4DYIfnzkP4o62oG7Ba0PO1jh8cw9vBAEJG+8ZbjIzwO1FRNx+g+S3ZzYMSgEj6de4HyKusnNLe9ruywpI1cavbot0Gsb9OR0lZ0xIMpll/gMD/lkMXLwzvZ1QP16z+xbWiD6ldyksU0oXGM4F2J5bT/nCJm0gdu0W5UJsVFBtkaZaKBq4NqTCSomqmJPG1dEqENBeHAgxkTzJiTOrqm8FbjzB3W7eJaun7Xg==
Received: from CY8PR02MB9252.namprd02.prod.outlook.com (2603:10b6:930:9f::19)
 by SA1PR02MB11578.namprd02.prod.outlook.com (2603:10b6:806:4d7::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.6; Sat, 29 Aug
 2026 20:44:23 +0000
Received: from CY8PR02MB9252.namprd02.prod.outlook.com
 ([fe80::b527:f7e1:ef1f:6390]) by CY8PR02MB9252.namprd02.prod.outlook.com
 ([fe80::b527:f7e1:ef1f:6390%6]) with mapi id 15.21.0360.008; Sat, 29 Aug 2026
 20:44:23 +0000
From: Nick Green <n.grn@outlook.com>
To: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>
Subject: [REPORT] synaptics_intertouch on ThinkPad T14 Gen 2 (LEN2072)
Thread-Topic: [REPORT] synaptics_intertouch on ThinkPad T14 Gen 2 (LEN2072)
Thread-Index: AQHdN/cNbo2/IXm0xEWI3w7vMNqMSg==
Date: Sat, 29 Aug 2026 20:44:23 +0000
Message-ID:
 <CY8PR02MB9252B5E325192960631C286CE7AB2@CY8PR02MB9252.namprd02.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR02MB9252:EE_|SA1PR02MB11578:EE_
x-ms-office365-filtering-correlation-id: 127adc44-6fe8-4f8f-14cc-08df060e4ee0
x-microsoft-antispam:
 BCL:0;ARA:14566002|31061999003|15080799012|15030799006|8060799015|19110799012|25010399006|8062599012|24021099003|51005399006|25031999004|37011999003|440099028|3412199025|102099032|40105399003|2607281247196008;
x-microsoft-antispam-message-info:
 =?Windows-1252?Q?LyHsMn4VrjdDYmHmZEHOBY/49g/dFt0mF/7VlfEpy/BE3PjQ5USqWEQl?=
 =?Windows-1252?Q?tJ+F2A5F8uG48ljW0Wu7vXVA9oIr13iKp+eXzpz14q5tsysETfdzWPE/?=
 =?Windows-1252?Q?8EnwdVXA8bf2BPevC1YzS7W+cD9oOLuO/vIw6jNAeEIFWmNxkmHjwzq7?=
 =?Windows-1252?Q?4ycUkKjHghda3xTBsBfv/n3PMLM6jCnWAGs37hF+rO7oV90OgBMjC6k3?=
 =?Windows-1252?Q?DFAbK8xznYTGzF17WZXtoGfFmGRKUWtwSRHwohb4uboKtac6Xz7ta6yK?=
 =?Windows-1252?Q?pVBWNDb3Mhl0pc/tRaDXlEfK2EP4IiOlh608xs2hA8xQaS1XiNUFNF8K?=
 =?Windows-1252?Q?FdJFWRxwA3b6Gczwuu0L5NZpEIA6SjkZO7e0wv7pCUzDbLifn9SJb5Y8?=
 =?Windows-1252?Q?6e1tuVNTSCsGZRc5TuPgKUaQw9kVgtoNtk6FNlwReKDJlCyohigWGKAq?=
 =?Windows-1252?Q?0VxPzZKK2AtnMnZ/FlQICr35Q+i97Vc28A5ADkckk492Q5/XqyyyWEzV?=
 =?Windows-1252?Q?3C3Xyq/vgKX0kOv2J5/iJJ35R+J+An5vDSA/6xhboWX9D8WzDWG1XzkP?=
 =?Windows-1252?Q?HGzRz+UPSjEGaqUcAF1cKmxyYcGQDjhkQl+LQ+OKmnzgJWwC43NtsQ0X?=
 =?Windows-1252?Q?wALp636aVek5qNkbiYu8iS+KTLQvUVqkjmIrsEpelqzTMr1/Dntq6xi9?=
 =?Windows-1252?Q?lxxB6BjgFoI73EthJ0vWvYR/KvdDqQe6hBi31qiw9XauaS0/cWP0SK9q?=
 =?Windows-1252?Q?vkrcIt/0jfk292doEFVTmw3+1aGQCsD2+OEYgItd72oZN9pKwsria6Id?=
 =?Windows-1252?Q?U/Zps4mo/bni3cIk6cQaR70hzSnPeasgO3xmfbklsWU3NjqiNEjF9UY1?=
 =?Windows-1252?Q?U3m3AE9OxIrcqRfEoXUmVOJzjfggt94zeAnAOqk9Ui8I9D3g72eScwFk?=
 =?Windows-1252?Q?6vKPQUlrgqQbD7lyx8+8kVxVFZFwaBA/Z+1hu7bDNPTW25qljIeVWH61?=
 =?Windows-1252?Q?8IoYolv+jRzNcAYoY7ozltdDe/FHP47H9E4COj1b1XBNbGhcJboHAqxP?=
 =?Windows-1252?Q?VLGBqZSxABbNhcBPZL+COJTCcH2jxBYuZmilndA10tjdYLWYxCQSXfBM?=
 =?Windows-1252?Q?Las=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?Windows-1252?Q?7BujPcEI9IMvtmYAxp6YigWz6/gMyfT5FiQqICK8IfnPXPfidIoteykH?=
 =?Windows-1252?Q?UxcFnSI9e9xy7kdBTR2h9ERCvqfAS8wwIsVpJmlO1kfkFS6rCPFmO2CK?=
 =?Windows-1252?Q?izRvX9SZU6wP4eKUYrEQMXotITK5BLhi3bPOUXKZ3U4W8s6ya/ptiEn2?=
 =?Windows-1252?Q?blyKYK9yp9ExWJJhIq6biDFDaRwPc7Hj//+0fgGB6iupS4+y2OEJfTRd?=
 =?Windows-1252?Q?3qPJbrAvlQIXWeX8JKaV5h6vjaIoVuHOs5wjAI5bi1gQsAWEqXRZh9yo?=
 =?Windows-1252?Q?06+GecTOnRhmpg8ff+NFOWQvszIjE6IX5KUpKVWaRbKU0KGztOE/8Wqb?=
 =?Windows-1252?Q?CRPYjBlZ6iYa0OtSAVKT69jg14BxCMqzTbIEyNsHe0MOmv9efJnE2ZGL?=
 =?Windows-1252?Q?EjAU/PoWWkdeidLYA7D/IthWC4o6wO3hg3yOCBv8xmU+8JBvPCRKTvQV?=
 =?Windows-1252?Q?tv5nncTnpMCZvlQZT+uR9bRbO3lIu4oD+gn/VOiicl6FIXcCwk89+H92?=
 =?Windows-1252?Q?FYPtWM0sqns9vhkOGYdD4UnAsYQduzGf+OFxfTybyrEG36jfOE8n3yqL?=
 =?Windows-1252?Q?t1w4s8d7jtzQ3qaEpq7YLl6haZ3FtAfO7rfosI1dftjWiT11U29Zfi3H?=
 =?Windows-1252?Q?IpWHnCvps8Q9WUPry9Z6GMoUMvgwNr36CX2tv7pPNuT8SD4FRYRQPwo1?=
 =?Windows-1252?Q?1h+vm9okKKe7UiPlk2E1J1S8kyRlj5ivXjnDzLP8ddXogUrAel7GYXOA?=
 =?Windows-1252?Q?UYDDrfGGNfFUHNQ6zv3Hw/FuU5G7mcEswLGqou93nlb4SWmbFhSYKKvv?=
 =?Windows-1252?Q?siUrX5tlEbXII0RHNJWMIWUMhtQGHEnLpdFfF21XcOj4F514AYVPnxcX?=
 =?Windows-1252?Q?sDoesUhxVNh+CXfd55Wv93IyUKGssiwSxlZZPFIxqOvGhuCEz2JcfUL5?=
 =?Windows-1252?Q?aVe2CAJfoD4EwM4XllUlrR1GItQYItge6zctO/FUrsiTYwl4Lmw1Fmpu?=
 =?Windows-1252?Q?u0DTzcYrceJV1yOb1K2b4EjenDbp626jJ7tdetRE91kK5guqtn8oAlKs?=
 =?Windows-1252?Q?45rLwikEUS3KI3lrx2oyM+JB0hB6Zzo7VJJ53ID+tbEiUbxEVwj7+BXc?=
 =?Windows-1252?Q?LhDkcfLK1dt8IBr+wMS/4tDmxK2CdYHXEZZ4peD+mGKwHR+v3VM2kBzM?=
 =?Windows-1252?Q?RToLFZN354pH1duaPuEn+Ai29oV8hjFAAPYL+1wyn15PmqxU5yDWxGNt?=
 =?Windows-1252?Q?7LCLRpe2kG/PcmwQVhwf3M9PkmSzuD0Wfk//IJKcZsb4UufcXevNEP+B?=
 =?Windows-1252?Q?sIRy958wUMqV+BjNqC7UKqP4fTub86Gsl6l56I5Un3MkK6Ne8gvKvpuh?=
 =?Windows-1252?Q?WEDvNVmp0MPMhCP4+U4JZOU7JqWgxLxohGCoMfY92k+4rj4uf049i0eP?=
 =?Windows-1252?Q?GB21IUubZgGyznlaQFU1GwPpSNnrQHm5m3N7PpsD+hU=3D?=
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR02MB9252.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 127adc44-6fe8-4f8f-14cc-08df060e4ee0
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Aug 2026 20:44:23.2411
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR02MB11578

Hi all,=0A=
=0A=
Following up on my previous report regarding synaptics_intertouch on the Th=
inkPad T14 Gen 2 (PNP: LEN2072).=0A=
=0A=
After further daily-use testing, please DO NOT add LEN2072 to the smbus_pnp=
_ids whitelist.=0A=
=0A=
Key findings:=0A=
1. Under psmouse.synaptics_intertouch=3D1 (RMI4/SMBus), the touchpad exhibi=
ts intermittent tap-to-click failures during natural use.=0A=
2. Low-level event debugging via 'libinput measure touchpad-pressure' confi=
rmed that missed taps produce zero evdev events at the kernel level=97momen=
tary tap interrupts are being dropped by the SMBus controller before reachi=
ng userspace, while continuous swiping and pointer motion transmit normally=
.=0A=
=0A=
The default PS/2 driver via the Embedded Controller remains necessary on th=
is platform for reliable, zero-drop tap detection.=0A=
=0A=
Thanks,=0A=
Nick=
