Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011014.outbound.protection.outlook.com [40.107.208.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00D5C3A8F7;
	Wed,  3 Jun 2026 19:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780516103; cv=fail; b=cvPMo4RrlWG8QRPbU5EDe8UAg0n4pPiSaXXiBQLosvyOwWTc4dQiaUwCS0omrskiwkZcXrFC3EVAjvMrWN3UJRvLvbcHK4Z2WAd6jxJ+ApIXK7muuroE8e+lrE1b1TfgK0ef5iVHaoG4o1dEPI+8GEb/jk/JJ6y/h2ExZ2JM74Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780516103; c=relaxed/simple;
	bh=pjEULDInti6spK1cerWn1bBB9WVo7ASBau2tEXTBfos=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jdAmJaYCTX8I9u8PNbnBuNZWqxYcRdVQ1qlm6IRwEe2/j4OkwAAlDFNUknZ2m1gMW+JCTty1nirq2zhCA3XR9b1vI7Z+/PA4xKinxl6zt/qRYiV9b+n/BUWMcLZdMcyKWEATrTUgY+pHyYwHAgiKZ6k7LEpMlg47wnLpf7dKMxs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=rEaSmH12; arc=fail smtp.client-ip=40.107.208.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="rEaSmH12"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LCu1McbAfIikZ7tzeijn760nXytIz4qbIBG1Nl8fgk27uQe88e+SKCIYcfDEbDdOvk/0Y1Q5/b91PmGXfumO6HV/N39XyvxkHkmByn+1OIaY23/ShZh0/9BpSAOmX6Rq7espCpy7BKUvxSCdyU3IOLra9aCVZQ4MQm1fE6V/0ULQ4Ju7vWhZJAhlU6uX1qC5zur2rjUfDXitUH7EHDTAa7PQT+/JEY5R4oE9XBE/1gE7je6N2JC9ndqhXKDqSPB/HO01BhVBpG8BwZSxqxlu57MNFWGXgOTIKaUe2CnWhApIpbp/5Z1u/5rgZHUkQedrrm+Q11hqk/m99Z3hadfd4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pjEULDInti6spK1cerWn1bBB9WVo7ASBau2tEXTBfos=;
 b=Fj8WkPQnuDO1+iOLY7z+yg20fPhqIm8gxiQidUeBDyHuqQCcWWrWKJc4ruVYYLQjgJlIYuywtWBQ3x5D8797GvCACmsjaQdkGz6AROaQkrdKmlWSfoh1fjwirw6Ad/NjazC22ox0geRIYVajpxNMKzftltjPQU3r77Pfxv2nVwJq5SXjkRs6voK7sI0N6U9Eble0oEcESku+Z0wNG/0RzrNAkfAM8E3cMa8Pt2EJwYqJfdtkVQJJOpVqOs3wKFQPMKhUxMPj68c9VnCHqC+IZI0RL/wM7B0SOH6OE1kmwr0GH4Ow0R9ZCKM+kVZGGeikMFu6TPNRr1g3/kC1HTNHXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=plexus.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pjEULDInti6spK1cerWn1bBB9WVo7ASBau2tEXTBfos=;
 b=rEaSmH12mSKYPzgpHNuQWp3UZEap2LMYdf12H7OoJzwgyeHNESOzqbh4TmE1FX4Xj4d5AJSATUN1rbb/vy5YnkY4aG/xWiIi1FOeYSrNRq1uBns7reIBDh4VJBGA+RO0c8EFRpY7KZ8N5FTqhX/JTZLAw3ktR+G45jmpEnlB8FNFfnadp1VW+U0q7Hlt9KAQRJ2FZK3DFDqddccFtyicrMe//Uc1BMtwx5LJISk9ZRTDuPK1vaNRqt8Pi64ykZ92wfB7WKAg7g98eOIJ8NBIBKlkLTGb48Z7vIXNRGWog9I+H/pNRRdHrIOyVbTl2d3cTtQaI8KKeSV8Q6+YqyV7FQ==
Received: from SN1PR12CA0083.namprd12.prod.outlook.com (2603:10b6:802:21::18)
 by SJ2PR12MB8718.namprd12.prod.outlook.com (2603:10b6:a03:540::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Wed, 3 Jun 2026
 19:48:17 +0000
Received: from SN1PEPF0002529E.namprd05.prod.outlook.com
 (2603:10b6:802:21:cafe::af) by SN1PR12CA0083.outlook.office365.com
 (2603:10b6:802:21::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.7 via Frontend Transport; Wed, 3
 Jun 2026 19:48:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SN1PEPF0002529E.mail.protection.outlook.com (10.167.242.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Wed, 3 Jun 2026 19:48:16 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 3 Jun
 2026 12:47:58 -0700
Received: from nvidia.com (10.126.231.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 3 Jun
 2026 12:47:55 -0700
From: Jacky Huang <jackyhuang@nvidia.com>
To: Danny Kaehn <danny.kaehn@plexus.com>
CC: Jacky Huang <jackyhuang@nvidia.com>, Benjamin Tissoires
	<bentiss@kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Andi Shyti <andi.shyti@kernel.org>, Conor Dooley <conor+dt@kernel.org>, "Jiri
 Kosina" <jikos@kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	"Ethan Twardy" <ethan.twardy@plexus.com>, Bartosz Golaszewski
	<brgl@kernel.org>, "Leo Huang" <leohu@nvidia.com>, Arun D Patil
	<arundp@nvidia.com>, Willie Thai <wthai@nvidia.com>, Ting-Kai Chen
	<tingkaic@nvidia.com>, <linux-input@vger.kernel.org>,
	<linux-i2c@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v14 1/2] HID: cp2112: Add fwnode support
Date: Thu, 4 Jun 2026 04:46:53 +0900
Message-ID: <20260603194719.403557-1-jackyhuang@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260520-cp2112-dt-v14-1-b1b4b6734b6f@plexus.com>
References: <20260520-cp2112-dt-v14-0-b1b4b6734b6f@plexus.com> <20260520-cp2112-dt-v14-1-b1b4b6734b6f@plexus.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002529E:EE_|SJ2PR12MB8718:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c100ae8-2029-47b2-bfe7-08dec1a90e38
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|30052699003|36860700016|1800799024|7416014|376014|22082099003|18002099003|11063799006|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info:
	PvXzfewZzDqwx2QzPA9b2j2yrkZM/b6vjL9cdea1m+cHBsKvKgg7oeIqEzY/zqg6+9i4fC57lgfQ1iFAe4lB8Dd+v6fhAIBakiJ9Xc6ffqab4Co9EUZG+d4DtKv+svYlq9EsIQIPVpyt0WW1SitzG45UjB62gWSWxe0c7c8GjIUYX7NfegMzjpMrzmrEOxoxCJ/xy6pQCuyHRCxGBiMvSCBStViLok7UqZ2DhX80Wy2TKPAc0FEM7ylAzDDmaMXOxK8d1eK719yIfAQS3aNAkptKlFsHZfiFN1MvxMoygVNrDchbJeE70GriYuWcs66yw+avfAoPDizGRBL3xEqjXkX+kwwrgQLP1UYKRmQCJLpXR7dFRrFiyxx1RIMwpzx1YyYljFYN3n6XbMjgMQNbFvN+P5SNKp09CICeGEzHq7YhHZlBeqXJA2KNtipxQ72EjdA36IKl+PSbL4cGqdHMEnVwiz4ucHhaw3O3AM+hqm5plO7EZseL3sKN8D+YJBcz3Fm6GV0mOXRtVXg4wXHUvaX//6+P6hDv7trYcwunpcbsUBkg1/y4H91q+K1p9NRDP9w7Tb5IKJNDdGGxHVkNwnqbcTGhjigSQHUo/VQEB2w4uagpmMHgd2IM+Eb7Cz6KOtfHy03DshxYU/3Bd5hqu+YuNVGjX2+gL9dLl2MWylYR5oOfMongxldz3SHEaf9ltXm84KK99ire+G41Wa5g/HvtGVwyfhUIjWDws3osHZ0=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(30052699003)(36860700016)(1800799024)(7416014)(376014)(22082099003)(18002099003)(11063799006)(4143699003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	3VGlcGOEaaUNg3iok85faf0NatW4/ZArCXftEUsJE08NmYVKCCEuIaFM5SYUtdMXjFH7+6/9zOl/MiTxjZfsTCVXV9NCH/nLAB0HOF3mtKqwraAYmWqyupWwmIZx8QjhCYw7XQ1X2Vu2fpy1QVCc+CPOVns5Pj2EEVcCis85RvwOkhmg4fHW0AU+VfgjpxoZ4LuLsuwCKkyAPL+MOgf1wRUPM+xTT8LvqA6S+cTbVP2bIag+DxxWTL1qVfDSLi/0dklEtgPx5KJHNiM2/hbXciYogfjao3EduL+TSdvb4X47zR66zyi0OJ7B4iRLDyhVrb1X2TrcT4y/S70w0at/in3ZuxEMLlOUm6Fu+F1UwVmM3OGFS4Rh3adlg4ghjE2OK9RMHXV4pJPuTqZsnvrSeSHHXq5a4mmx5ii1YGt1gENUWVZuoOb3m9Jm+XpyT0lj
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2026 19:48:16.3959
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c100ae8-2029-47b2-bfe7-08dec1a90e38
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002529E.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8718

Hi Danny,

Thank you for all your work bringing this through so many revisions, and
I am glad to help by testing it.

I tested this on an AST2600-based OpenBMC platform (NVIDIA Vera Rubin)
that has several CP2112s. With this patch, a CP2112 whose device-tree
"i2c" subnode declares downstream I2C devices (PCA9555 expanders) has
them auto-instantiated by i2c-core: they appeared on the adapter's I2C
bus with their gpio-line-names. CP2112s with an empty "i2c" node
registered their adapters but instantiated no children, as expected.

Tested-by: Jacky Huang <jackyhuang@nvidia.com>
