Received: from iad-out-006.esa.us-east-1.outbound.mail-perimeter.amazon.com (iad-out-006.esa.us-east-1.outbound.mail-perimeter.amazon.com [3.216.221.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40FF1149C6F;
	Sun, 26 Jul 2026 04:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=3.216.221.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785039197; cv=fail; b=Xmn2VsOo/GXlOdNxpKch28JnjlDGeZwT46ZNK+K5o4cQJFFXX1RZZmSmSovZtBPE3WXXkGeVNIZucEItdIyb/i78weZvvi7YWAoVB67fjfnq1DumZ533aS62KgfK+u3gXemh2ls4A/50DOIU99h2hBZz16mQTru395/4Ufi9JFk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785039197; c=relaxed/simple;
	bh=8uPzjP8Zxt9qzTHd2fz+3JYG7uF/93E8AK0mrYYCQYI=;
	h=Subject:From:To:CC:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=RCWsW6SZ7UdL0Y8pv1iFicidEC371DWyMGEZbhJsnnu6mDKjqpP+SmEuFWuVfkNZvds4MiN8rwK7ksWzo8KhhxeWnlTHN8hYc8RPlOvz7IfuW7b4agMf+NrqCJBmkYPP7tsR18SZW57u5Y7WXqzmfYp3/SKOAjnGvhyPpjNlNpg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=NZwPtb20; arc=fail smtp.client-ip=3.216.221.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="NZwPtb20"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1785039195; x=1816575195;
  h=from:to:cc:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version:subject;
  bh=9tYYPeFNAfHfcN7fGSotQubSIJeq7vASLsDXAEhHxZE=;
  b=NZwPtb20L7d132KuJWI22oy/ouVic+jwZTAgFQKy86N2p2YTXO/DCZ9h
   Xo+ST2Eq01nL84WS2b/2Ep27haR4O4ifbe6EP3hOx4vKYHAZXz9IpQ45B
   5yzC3Ne/ATe9h8kmyl7a+hhiA+42jKJfDUixzqW5yi9tvF/XaECbX1W8W
   At4TN2GszNMvDLuwpjprQQXqU3zHxnY0+1yNzsylmbjLgJ+gsG/REjkaf
   93r6typDbsDYUnaRT/7kKM5cPAb1ybyYreJg3AMwWO1GZqHsbl4jCjTg2
   h1jSFOnjpTTFqwimKxYsKZjTTnCKmGEfIZdpAn8vT7mZKS2XLKysulFYQ
   A==;
X-CSE-ConnectionGUID: OaJA9W2ISKGkHJW8UZW4lg==
X-CSE-MsgGUID: MwkZkCj9Qb6K8WggpOzarQ==
X-IronPort-AV: E=Sophos;i="6.25,185,1779148800"; 
   d="scan'208";a="23579809"
Subject: RE: [PATCH 08/12] ACPI: APEI: GHES: use
 devm_blocking_notifier_chain_register()
Thread-Topic: [PATCH 08/12] ACPI: APEI: GHES: use devm_blocking_notifier_chain_register()
Received: from ip-10-4-7-229.ec2.internal (HELO smtpout.naws.us-east-1.prod.farcaster.email.amazon.dev) ([10.4.7.229])
  by internal-iad-out-006.esa.us-east-1.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2026 04:13:11 +0000
Received: from EX19MTAUEC001.ant.amazon.com [72.21.196.66:32024]
 by smtpin.naws.us-east-1.prod.farcaster.email.amazon.dev [10.0.38.68:2525] with esmtp (Farcaster)
 id d32c72dc-0ef9-4f55-a73a-b95e04c7f70d; Sun, 26 Jul 2026 04:13:11 +0000 (UTC)
X-Farcaster-Flow-ID: d32c72dc-0ef9-4f55-a73a-b95e04c7f70d
Received: from EX19EXOUEC002.ant.amazon.com (10.252.135.179) by
 EX19MTAUEC001.ant.amazon.com (10.252.135.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Sun, 26 Jul 2026 04:13:10 +0000
Received: from DM2PR04CU003.outbound.protection.outlook.com (10.252.134.239)
 by EX19EXOUEC002.ant.amazon.com (10.252.135.179) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43
 via Frontend Transport; Sun, 26 Jul 2026 04:13:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vK6EaxN4UtgIIyCgpomVNoBNg1+invYHZN2Yk31vYeVZUXMYlP4ZpkThcBweJs2O9TgrsNeZNJT97r7nH+0IaBp/GNyEAE2HBOT0C+PwAm8OkDiIwmLmFv1TkZWTxq6d8kgf7QOD5KaJJb8ZxGg6BzDiFVqSTd0AqC1IZdaQw0LBVEm/m03Km9MGQXYeyy9WV1Bbr5c/no6tkB/+QkWrm5cVgmmRjbqMISgOnB1lUxKQQ3aXlMjM504RDU72F2ydXCsszirj9BrphU8waOzS3so/x4MevewyAWBnxH21GvD4s76VFhDo7zqjRoIbmT/Km7TtxrgwHYWJ3FnmoqJJoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9tYYPeFNAfHfcN7fGSotQubSIJeq7vASLsDXAEhHxZE=;
 b=fHIusRjKDKuovK8607deP0HqD5FZ5yjfSAJMyoDdN+EMZxfrVYaZW8KeVr2xZwmQIf7NMDQks8U2zNqKKoOduvMRkSKJjnwkm7vFZGqqyk0LqdQoKv8SGBlLSKABBbA9Tmuc7yA7K/9OWRJzoPj15A4vMdq87US9Bf4TCw1Gdzj0MaeV9BoUkc0k9ZDZDlzNfRFLjYSxITmzfPRv/IaEIGpPtSJBVNw9a7+hv1O+hA/1fGPVWZlnqib3vL1NqOxkYDzfhqh2CjRBgEXc10yvocCJgdwMm/dTR7mTFVKj6Rc70MDCAmJLaLR9b2aihn1C+JjXCGjMtKGbDJw1ay2Sew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amazon.com; dmarc=pass action=none header.from=amazon.com;
 dkim=pass header.d=amazon.com; arc=none
Received: from CH0PR18MB5433.namprd18.prod.outlook.com (2603:10b6:610:181::16)
 by SJ0PR18MB3833.namprd18.prod.outlook.com (2603:10b6:a03:2cb::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.12; Sun, 26 Jul
 2026 04:13:07 +0000
Received: from CH0PR18MB5433.namprd18.prod.outlook.com
 ([fe80::db:2f3d:fbda:8905]) by CH0PR18MB5433.namprd18.prod.outlook.com
 ([fe80::db:2f3d:fbda:8905%6]) with mapi id 15.21.0245.012; Sun, 26 Jul 2026
 04:13:06 +0000
From: "Farber, Eliav" <farbere@amazon.com>
To: Jonathan Cameron <jic23@kernel.org>
CC: "rafael@kernel.org" <rafael@kernel.org>, "tony.luck@intel.com"
	<tony.luck@intel.com>, "bp@alien8.de" <bp@alien8.de>, "guohanjun@huawei.com"
	<guohanjun@huawei.com>, "mchehab@kernel.org" <mchehab@kernel.org>,
	"xueshuai@linux.alibaba.com" <xueshuai@linux.alibaba.com>, "lenb@kernel.org"
	<lenb@kernel.org>, "laurent.pinchart@ideasonboard.com"
	<laurent.pinchart@ideasonboard.com>, "linusw@kernel.org" <linusw@kernel.org>,
	"brgl@kernel.org" <brgl@kernel.org>, "orsonzhai@gmail.com"
	<orsonzhai@gmail.com>, "baolin.wang@linux.alibaba.com"
	<baolin.wang@linux.alibaba.com>, "zhang.lyra@gmail.com"
	<zhang.lyra@gmail.com>, "dlechner@baylibre.com" <dlechner@baylibre.com>,
	"nuno.sa@analog.com" <nuno.sa@analog.com>, "andy@kernel.org"
	<andy@kernel.org>, "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>,
	"hansg@kernel.org" <hansg@kernel.org>, "ilpo.jarvinen@linux.intel.com"
	<ilpo.jarvinen@linux.intel.com>, "W_Armin@gmx.de" <W_Armin@gmx.de>,
	"ukleinek@kernel.org" <ukleinek@kernel.org>,
	"fabio.m.de.francesco@linux.intel.com"
	<fabio.m.de.francesco@linux.intel.com>, "kaihengf@nvidia.com"
	<kaihengf@nvidia.com>, "ankita@nvidia.com" <ankita@nvidia.com>,
	"leitao@debian.org" <leitao@debian.org>, "pedro.pbg@usp.br"
	<pedro.pbg@usp.br>, "paulmck@kernel.org" <paulmck@kernel.org>,
	"frederic@kernel.org" <frederic@kernel.org>, "kees@kernel.org"
	<kees@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
	"linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
	"platform-driver-x86@vger.kernel.org" <platform-driver-x86@vger.kernel.org>,
	"Farber, Eliav" <farbere@amazon.com>
Thread-Index: AQHdGsx6xxFWSwXni0+Ghjhqm8YakrZ711CAgANcnxA=
Date: Sun, 26 Jul 2026 04:13:06 +0000
Message-ID: <CH0PR18MB54330BBA46834A7087AFB198C6CD2@CH0PR18MB5433.namprd18.prod.outlook.com>
References: <20260723175513.39849-1-farbere@amazon.com>
	<20260723175513.39849-4-farbere@amazon.com>
 <20260724015043.37cecbfb@jic23-huawei>
In-Reply-To: <20260724015043.37cecbfb@jic23-huawei>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amazon.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR18MB5433:EE_|SJ0PR18MB3833:EE_
x-ms-office365-filtering-correlation-id: 10f31c25-3a47-4aaa-651c-08deeacc320e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|23010399003|366016|38070700021|10067099003|4143699003|11063799006|56012099006|6133799003|18002099003|22082099003;
x-microsoft-antispam-message-info: anmcS4gGTlki3xtJ7LqU74E0O23E/AAhVtLboKcT3noGLUlKqVyXDafb/redHs1ltgIYOAeWDm19+5lDr3LNUn4AGiiyXX0EoT5QV0yFE+g2N3+FyiMcl5TpWgd53tiwba0rPlsoYZnrhnukDnNyZ1HPdPG5KrdHFDYIOrQypfbngD3nWJIhGCUNhYECrAc3YDAfUSf6aEfPbn7hZuomUuV1t2BxH1BftDGEDVLYlFskT7wCaIwuz+NMcCFe+J364Ae+Qy62HoE3iujhTTGAXOKa2S8iHVaOP2JYfzeaZkjBNkneT0o5wWIlJl3edBEnzfVv4OjFJDMdxXBPCGlBGm9TiT2q5cbBnru1cDNLlNOf6VaKJLGtuDV/1pn8vByrK6Q9j8uFvE4Q6r4fyQJEpXYFG5Ybu1ASaGBv4OgOFJ0I/mz7QGjBBnfLCNo9Omwl6CxanLEQe3FEo9GakEGScYQGQP/bZEfFsWAJh0AJSH57Mqyo63kkZQje+UEwv9qfTx+8hgotppnkaPZe34w5MlHtt3wTFtJT3bxdMIfBiPWvJkUK9PL9iWsgKsO88/t2jY4eN3i6EZGr1vUJpbK+rOxPh3KdWH8M+ME0Sx36kH4GmZ4QJmHaQ3UcJKDJadDMvHo4J/pEXYZOK9nHYnjhhAWgOx8nyPa9iGEgk7VPYolryx1RIs77zDgPblnNMQZnEMXx5hxq6OnYwUA1BqydKWRw4FFCV7f1xsOKz+PMoxc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR18MB5433.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(23010399003)(366016)(38070700021)(10067099003)(4143699003)(11063799006)(56012099006)(6133799003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?UB5CEkxbeo2DgZBkayCJU/4unU953TJtKWoKh71U2FQaWH1ZuPFFT7sI5sPf?=
 =?us-ascii?Q?l7ASANQq5TItFtIV5u5Bf/3I6jhRL7g8wvicvU3/zGoLj0HCp1OMrHhxdutn?=
 =?us-ascii?Q?A7jCG0EQSQFaPvaQb+ZARDANqMWkBvGD/z+1UH5VmVct3wVgJRckyU3QuiHj?=
 =?us-ascii?Q?oI9qEK+2HNo9ZLFk8A4CSq5oPOGcmmD4xoR4Y/bYE/PJ84KRu9Z7UP8Tr9KY?=
 =?us-ascii?Q?fZGtk+eAzw3Qf5qdm+CJAD3kFLv7ojx1bT/cFNumEfBLWqOXCN7dw3r8TCDu?=
 =?us-ascii?Q?o8H0tTleuiteF0Jg+6T2xV2F/Hu1DQjdFGQM9sBiqRT2AwvGVbSTjJcaSi/f?=
 =?us-ascii?Q?pYjCgGQP63EdhAKhg1RC1zp6UEBbdmKM91I0K42es8OUbciugi+1U3nxv2eE?=
 =?us-ascii?Q?JoO/RdA42idUl2sm4TJb2c32miePR2AySwSi7O88bCMofEFynAUJOCsvAW1k?=
 =?us-ascii?Q?sHJwVGQyfZUyIzN7DClGM77AszzV1z/99EpQnDR1eKyZzj4N3WGUVH5wAeW+?=
 =?us-ascii?Q?8Pi2t6cYi7/l67+RESjKEVtjrtyEmCiAG/w2zzkiXCGdIyP/T6PeCsJf7818?=
 =?us-ascii?Q?KovFu2yW3onY1y9LN7PXrxudie/PYGauz5YrjzLNqvTcCoQPlfoaURPbZVEa?=
 =?us-ascii?Q?8LUau2NjgywlmIZi8O4bG016za/Hw4mL2j3P00F6l626SSLZv8VwcEP8uMVP?=
 =?us-ascii?Q?VA9XEpezwSpDBXcZFlUHS/hIK75VHOX87masDSwAJpwRDCCBgEzk+XWlc7Ts?=
 =?us-ascii?Q?ryvpb3MEEaWhbpjBhhixBMSyhhPCo7OSQqa2C+TwtVispfNWH0lux8Vh8C8y?=
 =?us-ascii?Q?eY/Guy9WRpoURqCTAaO8Q2al8P9H+s3s2l/MTOHC2QSHUVibfdvd5mXt06Ki?=
 =?us-ascii?Q?eMAv1yS+v2d8IvD+/svXOgvWeMMfXgS4MMha4vqfiiiqYDkVd6ZY6Zasmc5+?=
 =?us-ascii?Q?bqWrE68146jwa+tTq2c1e4cKjGv/N1oBygNCXgC813xihA1ttO5IwGXkmwL4?=
 =?us-ascii?Q?9GnglbhNYSFfQw95ML22Io6fGTX3SDNPiNc70t+ExbrBNTgWSLI+dHVlgvSo?=
 =?us-ascii?Q?XJ4+WlwE8bMUjexLWQWFCjR8NLJnCidnONqnjBbK9W4XkdZkFLUIG34CgXiq?=
 =?us-ascii?Q?MP+3GjwbLHvAoekfpy3RChlm2Rh1Uo3bjhVBxRLo5MiVIIKfNB8uXKFxoED/?=
 =?us-ascii?Q?lZWWAoHbW4MOonisLaYhZMA8yhvtroMr/6sAAYlc1jovQvYEHESHss20VV2W?=
 =?us-ascii?Q?DZi1CFXS8v9ACWPcWITzVNbDPuA3kFlMXujY7GHYmicYPpvO0BOYi+2hFj9m?=
 =?us-ascii?Q?4SSyAZqQe4ycU587FmtCwycT6AdqsTzVNLY5zILFsMCYypl8y0i6qLjFvw9m?=
 =?us-ascii?Q?2/j0N+8LGkJs2tHfY9146AeNbadOaPy2Yl4Yp9YuWDv94aQO1XYQ4OjmhPRP?=
 =?us-ascii?Q?8Efw2Ko6la+lvWbOLKGVVSBLLILuI/h4DoXwK33ktToT9W/w2YHZ2V2KUjUl?=
 =?us-ascii?Q?4PcmD4IcGB7MGukl2Vm2kqnkD8Tohy5QuPDYE4v353IzEb4H1csDIke8x00W?=
 =?us-ascii?Q?3I7S0WUza/htIFlzx0o/R6RFedct3TtYpE5Gyp9kRHVe/7hi94BARB1O0uJn?=
 =?us-ascii?Q?4lBEXQNib+PLDImY6uuYsLXB0ZaskPL7eA0fZYso3UOETDcE1vIMeh6owJxO?=
 =?us-ascii?Q?K5zhgTlbYAhHNz0pbaTg5+UHzmKtf6EYRq4vGB7AxkrWpmEk?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: oz2ASaL/47dTYYW6l6VSws75aUBr8FiQ/FbfvC/TRzsJPF2mIxFw88XLlV5mB2kPTS0pskpECXYJ+sbSk1VchFt/E8+USr043RAQ3mLYRZZ8Wz0Xbay2BX86hhVumDADWE5GXQvFbWCiKMG3EqU94fAz6qIAjvAYfk7Un6QCgWr9V5gLg9xuhIoHBodsL75USK/SX3W2Ocj3ey656FpOPRkltp2IgySvizEN41jjm1v8uVryb1gEpX9DLM7G0QMj2KqLd6NpQ+2ojHBWWS71Z7BJVgjqc/MZLhMOCpF25jtx2ZhGigudx7MlPEnzqqxyrGip5rB8UlGZFSZpMbgxog==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR18MB5433.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10f31c25-3a47-4aaa-651c-08deeacc320e
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jul 2026 04:13:06.7183
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5280104a-472d-4538-9ccf-1e1d0efe8b1b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tuY2TEp5VBRRGela1R0DHfLjov7oUdNknCrn8dP/HjhCGeBKq7pNETxSarjLybXjqikZWLmBWDW9o1AkZDRe8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR18MB3833
X-OriginatorOrg: amazon.com

> On Thu, 23 Jul 2026 17:55:09 +0000
> Eliav Farber <farbere@amazon.com> wrote:
>
> > Replace the blocking_notifier_chain_register() +
> > devm_add_action_or_reset() pattern with a single call to
> > devm_blocking_notifier_chain_register(), removing the
> > ghes_vendor_record_notifier_destroy() callback.
> >
> > Signed-off-by: Eliav Farber <farbere@amazon.com>
> > ---
> >  drivers/acpi/apei/ghes.c | 15 +++------------
> >  1 file changed, 3 insertions(+), 12 deletions(-)
> >
> > diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
> > index 3236a3ce79d6..3aa29dcd70da 100644
> > --- a/drivers/acpi/apei/ghes.c
> > +++ b/drivers/acpi/apei/ghes.c
> > @@ -689,21 +689,12 @@ void ghes_unregister_vendor_record_noti fier(stru=
ct notifier_block *nb)
> >  }
> >  EXPORT_SYMBOL_GPL(ghes_unregister_vendor_record_notifier);
> >
> > -static void ghes_vendor_record_notifier_destroy(void *nb)
> > -{
> > -     ghes_unregister_vendor_record_notifier(nb);
> > -}
> > -
> >  int devm_ghes_register_vendor_record_notifier(struct device *dev,
> >                                             struct notifier_block *nb)
> >  {
> > -     int ret;
> > -
> > -     ret =3D ghes_register_vendor_record_notifier(nb);
> > -     if (ret)
> > -             return ret;
> > -
> > -     return devm_add_action_or_reset(dev, ghes_vendor_record_notifier_=
destroy, nb);
> > +     return devm_blocking_notifier_chain_register(dev,
> > +                                                  &vendor_record_notif=
y_list,
> > +                                                  nb);
>
> Whilst correct, I'm less keen on this one because it looses the obvious c=
onnection
> to the non devm form.  I suppose with the code being so near
> to the non devm we can go with this.
>
> For that matter why do we have the non devm variants?  There are no users=
 in tree.
> Can we just rip that and the unregister given this is removing the only u=
sers?

You're right - there are no in-tree users of the non-devm
ghes_register_vendor_record_notifier() and
ghes_unregister_vendor_record_notifier(). The only callers
(pcie-hisi-error.c and ghes-nvidia.c) both use the devm variant.

I'll update this patch in v2 to also remove the non-devm functions
and their EXPORT_SYMBOL_GPL()s, along with the declarations and
kerneldoc in include/acpi/ghes.h.
