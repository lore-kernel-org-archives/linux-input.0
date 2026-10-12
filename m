Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11023119.outbound.protection.outlook.com [40.107.44.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0275847A893;
	Mon, 12 Oct 2026 12:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.119
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791807437; cv=fail; b=qD0aPl4ljDNKzaCl8yAxOOZsqsg5fP9Q8qwVHqlx5Q8ZdKfXgCoQiJFqbabS+OtYjjajX3nsx93JwzJVwAiOZL3/WjimsU96Zr0AwWSH3dWf4RrE6nT8uiy1zJ4qNGfeYtcsj6uqdRhpNDnCR50Fa+0T+z8HwHmTQmg+NuM1Tws=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791807437; c=relaxed/simple;
	bh=XDcqWVkgSrZrwPyaqidq7Z9gWXPw2/LR02uNFtzgKo8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Jg8BTTEjHs5pY/a98Q2mu309kXKtv/8E2xnLtrrDxH+CB0IKa9OihgVU0c9S87eDH0PGdwA3yyyLn3bbatJJ40x9OV0PPsW+IH6MbsI9fi8crct+rRu9jZsoyuKl1aFEeIwYA4m+BGSgOGoUaZXQRABK+Ouk4PdqSbuC20q3JCc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crepuse.com; spf=pass smtp.mailfrom=crepuse.com; dkim=pass (2048-bit key) header.d=crepuse.com header.i=@crepuse.com header.b=aFMTct78; arc=fail smtp.client-ip=40.107.44.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crepuse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crepuse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=crepuse.com header.i=@crepuse.com header.b="aFMTct78"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dLwnmiDU34tlNgUUYrTn29m2IedY1ZG6owj8KkGYuBV8kecJ/YPAdPC9LT9efzxq0e4e9nf8AfAY0SDRzlpXJXth12KqLns7vVLQbtCP9QOPDv/vGJ1mKdY05TLkcyvPpyAXDQmiw+N2sWSiIh4Vk83ysUYLg7v5fsdupx+4W4zQ3NMuy8RCEJL9NqF2QLbhZo18qtceMVLHlpvoih7je1CVB82IAuFoKhM2DxXRSOxidhG4S0MtmQuMX8rdLQ+n1Mour+DnXYFb71lCElQTKYANx58GT+HpYTp7WyuQR/xM28EY8moKUxDoJEEQ5GObnM3ArVnNFdE22l+cCCWzCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iIweXyRGisZ1shTKfX3ZNlx9xBFMXflzmB8w+TgEink=;
 b=R/CzN9viICHnrDm2+jTgB3UOP/2Y/ye1jJiif8oKkdXXaEFl1gpX3kE+BRYf2RJWcpLfWatsbVBqk+nW4NKeuJGQTOxOhw7ibgVxrNfaJnzaMuHxHos2h6IPj16YNZVTJtpCqatc5ip4AW2kF+LWA9jxJBJq/UsNvxzOId2AuQCQ5SGJIP6dmE45Teh4oHgDFh4Qpn2hKbJk/nNFyS8KqPWfBope8S+Q58TffzOjHblhRJWK3JQETQSju9zklqorPOJxy7Iop1Gi9e4YwZ5vV0OTS3EAN+FnvAjbKQgN61DvzLdGynfHrl/0/hbdZ8de6f3TSjXMb0O9PvgH7MBNMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=crepuse.com; dmarc=pass action=none header.from=crepuse.com;
 dkim=pass header.d=crepuse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crepuse.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iIweXyRGisZ1shTKfX3ZNlx9xBFMXflzmB8w+TgEink=;
 b=aFMTct78D/3sdRd/EjY9nSiNx/R+yqqs2ua2+etUslN9yubS9YK37Hmnp6f77/WFYz1l5R/8P8p14y5CPuw+sXoA/ZnvJ3CEvAYPXoXkkCrBjAjRw6UVPQ3HK1UNnYEF/81L3BaxBdhtAZnjmk9hcv9Ue1fQhuqatK2lwU9H0O4fwSYYMoKOlr68shXtgALt+C5AAMlLJj8cUdVApCKP/tKWctlnbMIitbKmUzPKsQ/m1vzh6FG/l1KhHWFpSwNo+SbDRjyfPU9olK/bqXg8EcFotzhPqaoeTJT+MWm/mpSDqQoDs5WpzwEKXe/m5ZcV/W2JC6DXdwYB0BXsQXaKLw==
Received: from KUYPR01MB8186.apcprd01.prod.exchangelabs.com
 (2603:1096:d10:8d::16) by TY2PPF1753F85B8.apcprd01.prod.exchangelabs.com
 (2603:1096:408::389) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.21; Mon, 12 Oct
 2026 12:17:07 +0000
Received: from KUYPR01MB8186.apcprd01.prod.exchangelabs.com
 ([fe80::fe2d:77d4:b78a:358a]) by KUYPR01MB8186.apcprd01.prod.exchangelabs.com
 ([fe80::fe2d:77d4:b78a:358a%4]) with mapi id 15.21.0496.020; Mon, 12 Oct 2026
 12:17:07 +0000
From: Miotsuki Mizuno <founder@crepuse.com>
To: "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>
CC: "conor+dt@kernel.org" <conor+dt@kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "icenowy@aosc.io" <icenowy@aosc.io>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>, "linux-input@vger.kernel.org"
	<linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "robh@kernel.org" <robh@kernel.org>
Subject: [PATCH v3 1/3] dt-bindings: vendor-prefixes: add Nsiway
Thread-Topic: [PATCH v3 1/3] dt-bindings: vendor-prefixes: add Nsiway
Thread-Index: AQHdWkOZxaIGNgavAUC/ZvgpC4O0wg==
Date: Mon, 12 Oct 2026 12:17:07 +0000
Message-ID: <20261012121705.53396-2-founder@crepuse.com>
References: <20261012121705.53396-1-founder@crepuse.com>
In-Reply-To: <20261012121705.53396-1-founder@crepuse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=crepuse.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KUYPR01MB8186:EE_|TY2PPF1753F85B8:EE_
x-ms-office365-filtering-correlation-id: 1cb60517-025a-455c-31d9-08df285abbd4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|366016|23010399003|38070700021|56012099006|261009223027099003|260925021311599003|260925022911599003|260925021911599003|10067099003|22082099003|18002099003;
x-microsoft-antispam-message-info:
 1azfjv8RPqNeXK5Hm8a0QhmQH6t0ZNQ5Xsi4iXMzs3YlyYPFllvfoI129pTlY/jVfWEgcUM1m7iyET8sY3bnN2xXPGJ4piNb2USFC9fUHCIh+wEPFjoYyh7wxRRlfWHeeLnn6OQuLX/fw0l4sNaPlq0FotTLSKYpU0uNgQVsuRBUdwba1w/oOMlZEN9Lx362N8BhjCxxPsOsyKsCOqfmiQnbGUIlLTHHtjCiX8D+0P4eM4VHhoLO22Q56xj6ecqWY1h/9KuO1HQxBaxBEiqx/Inq/lYlPZ/bfusUx+xe2HhoIQa8AEAhdzg7pnBlI3XBFQ+BxYqnwvE5MN3R/BhtyqCi+Annp6wgdxsM3bw7FVb0TJJypVdQ5XX0seRKhyJj+ZpqxK8RalKn27bQE1EtTamJMwxbrAy5BfGahRQ2dxQcLopYzNgIqtN0ZA4u3xJg7EghnNejbGYMjMTjWACa4+lZGUB71hD4t2ynwxFC02EkLGCyaIROeQvJFFR7yEKfMwzBKuWXyeTteQ4SRf8m434/QMnthZkSeyMqV2O+bwK6+zE2t7Z/Fh90jH8W95hTCp8GuJpalbs4RxEJHCOVBzBdEGcaYOerwBBUwBsnIFxtluSB0Wq3pfMO9LJloX9P2LZldsXL/YN9qP8uziw9IYhKHIHgpHqnj7ZlQoIFP+UqjyU1x5xiKOPuFnA5zY1bilx/tQ9Pk921sgPHDnMzyLruaaSQR5phXPYDqYGT1Zo=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KUYPR01MB8186.apcprd01.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(38070700021)(56012099006)(261009223027099003)(260925021311599003)(260925022911599003)(260925021911599003)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?l3GBlY++9+2xQbO+zzQWlWF1OWTDFmQnMBkyE3SYDK/R7eXE0eyKua2FXI?=
 =?iso-8859-1?Q?dsHlSDueKqU7//cBQ/74HC5fvb12N/h15ISNo6WLtbio2WyqEZXtrk/tzt?=
 =?iso-8859-1?Q?KMwz/sFPHNuwzLG3W9GihxrcXzinfcxxOiUIWv3q3PVRgBQmYp056yzW89?=
 =?iso-8859-1?Q?Zgl+Qmf6X1Gen61VUd8lQCYOGJ7NxQH9p5SnCK213K63WiEkdUpSmngXO0?=
 =?iso-8859-1?Q?ouzaBXiKoB9bozuARzdgXrFP3eVkzn7ZuEcsQgRO1OgbqMrDGn8RUDjlfI?=
 =?iso-8859-1?Q?NUQpNci3hbcHZvP5Z+OzSupCdvgt2ysaMSS4rWwFG4MCZeHq/ZlLkRvm7D?=
 =?iso-8859-1?Q?IWj8EhtcEda/Kk8jcfrI+uTB/7liN3ov46UV530+P9W3nNGtvH5nyNlIT/?=
 =?iso-8859-1?Q?J22Y5NGj2iSsNaeBpkpHVtRpXFuNblRRLSFChrtDVviFK6io3rdRksLreE?=
 =?iso-8859-1?Q?bAg2q/QxK85shoCa8PqzqbgeAVTG1Z6lLwz37rqSvUI81IBVi8gJzTKNn1?=
 =?iso-8859-1?Q?X9hJ9uVwcm8lNIKG3HGSTXBWtbGao7wT2Cjq8Nm0rTaNB/IT8xf5tGmtvR?=
 =?iso-8859-1?Q?LNF6LeYi+8y6kxS4TB161Chu7xszfCN3LiUp6CX1fOAy2OALKmLGGM/DAn?=
 =?iso-8859-1?Q?8jg3X6YiOQfE7Fl24CYssgZVJGTqHN5TJ9YfiozYwPx/A5utgWNXU1lri0?=
 =?iso-8859-1?Q?iOAjar5kp8gThqBseQ5lMdgn9MixByzzXFbGpBj2Dg5JAOtFgPDAedkZ2g?=
 =?iso-8859-1?Q?s4iBWomaqXPyMw3VZ+gwd/M1M6UB3GR0D/PfjKNsaav0KTryDkssfneLvk?=
 =?iso-8859-1?Q?PuVz8yNQaEtwn/VnwLeiUzrPha4tWN0VBSTHp5ZEWuOv619YPUORMXNA6w?=
 =?iso-8859-1?Q?kOELWkMfhkpgsNwu6gVL3fdM9C32NSXNMqJBaMsz1P9SQtueApuamTunjl?=
 =?iso-8859-1?Q?bRRnWUR2dAOvJxoIWm7VFcSV0gVw7vUs8ZibfXfB+PFBS8S1pxu8q6ngnL?=
 =?iso-8859-1?Q?nk37fG4QUH33Sx2rRls4eiwvUEutypaiDz3YUpKJmi6MTiVF0pyx7SbKXL?=
 =?iso-8859-1?Q?+MwoNCRGixywxPjR63DBv30FXqNnCFU0EnATk1F0epZvE17n3bMC+90vwO?=
 =?iso-8859-1?Q?jyGGEffpogoATQ5bqtwyWwdsmuhMz2AfYSOVuDdapGR6Rk/IlllLguGrgh?=
 =?iso-8859-1?Q?K8RhVBqshXH4DhW5loQSASFTjTB9lPc0s1XzO92yEZ5Z4+yUmFJOrejjQ6?=
 =?iso-8859-1?Q?yKUYvh+TG4tl2r34KnsaDEK1eJwQ+m4dqm8/XRjTpQOMdIcG3u6YabCho1?=
 =?iso-8859-1?Q?xqfMgenILQQ4QADUbEltK3odCKn8hhB32BIa1IWF1p2gxct9pG7YhBAMTQ?=
 =?iso-8859-1?Q?TU+WMrK4gm7bwgvJwr25TiFyodqb6I/aSjZNtZtYCHwhQjfYSe2B2a4K5w?=
 =?iso-8859-1?Q?wzdKNemTUUxsEZKHp/y+IYc2ZkWLxqf1awOv+54IhCPAR3uAyQNmGXeC65?=
 =?iso-8859-1?Q?gW4V+tPEmx3lMpThjQ8I8yL6q7fEMMtyaDxJPdmI6Pm5U1fOWauZWOPXeX?=
 =?iso-8859-1?Q?DgW8dhTGDbvQjltdZhe58meUdeouL5IYEJfh7zWPnpX3qmKdGMQthXQKPe?=
 =?iso-8859-1?Q?JZOeHdGE6iTdiucXkn0pphDMUkihJBQBgoR9lZ1R34uP0z+lhxp2FEDoVC?=
 =?iso-8859-1?Q?IESiEw7ijOiQ7OuF1tYOeDrIutW6izegK9IeobvaZL9Bkf42U4oeIrYys3?=
 =?iso-8859-1?Q?BYQoq4xbN+0GxszcFZF8+O3b1vn/Jw3zlkv9O7GJDM5oTn?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: crepuse.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KUYPR01MB8186.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1cb60517-025a-455c-31d9-08df285abbd4
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Oct 2026 12:17:07.3001
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9e189589-0b8b-4283-80ca-b0157c0a04fa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uR+VCL6PeMDBt/zj0gIjn5X9s41ucCYzPm64I0s54lMpOQefh4MFdW8l2Bx7u/ctk6Wuw/vez87OSMUlT83SYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PPF1753F85B8

From: Mizuno Miotsuki <founder@crepuse.com>=0A=
=0A=
Nsiway manufactures the NS2009 I2C resistive touchscreen controller.=0A=
Add its vendor prefix for the touchscreen binding.=0A=
=0A=
Signed-off-by: Mizuno Miotsuki <founder@crepuse.com>=0A=
---=0A=
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++=0A=
 1 file changed, 2 insertions(+)=0A=
=0A=
diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Docum=
entation/devicetree/bindings/vendor-prefixes.yaml=0A=
index ba2002969373..a180012054c9 100644=0A=
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml=0A=
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml=0A=
@@ -1214,6 +1214,8 @@ patternProperties:=0A=
     description: Novatek=0A=
   "^novtech,.*":=0A=
     description: NovTech, Inc.=0A=
+  "^nsiway,.*":=0A=
+    description: Shenzhen Nsiway Technology Co., Ltd.=0A=
   "^nuclei,.*":=0A=
     description: Nuclei System Technology=0A=
   "^numonyx,.*":=0A=
-- =0A=
2.56.0=0A=
=0A=
