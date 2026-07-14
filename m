Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 787E61E3DDE;
	Tue, 14 Jul 2026 00:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783990215; cv=fail; b=IWJufr114QooQYGvOGZYUW9pD0GEoEcrlZhtA+reFpqqUjAKbdIzpp2P4tUnyibXl/vaqwcoHPiNLq0uYG0i89jMM4BNTlziV2m6jHH7V7UEUUIFuHxmjQ0KfPQQC6UYs5/KP1NIyX/THUO15+UcCg7lMO7EkqDop3liVMNkS/4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783990215; c=relaxed/simple;
	bh=lOJUKEdTLuIkIq0mVG8DcWEHE/o0bMzeWntnPvSgr1c=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=HI3eMwaB/Ot8cXqKQ3t6W6BQk46YbyxRdRXiK0eFv4ityEFflp3oEactULnSPq2LF+W8KDWZvBhQf1mvL94W4SqiB3e3kFeMmecUtpuBYMRlgJIG30mUbXAJ9ajSMK1Nuw+PdlxOM273BVnQtNep31KsYPNFiiFW7YPg/FRwMZs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dcNjIrl7; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dcNjIrl7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783990214; x=1815526214;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=lOJUKEdTLuIkIq0mVG8DcWEHE/o0bMzeWntnPvSgr1c=;
  b=dcNjIrl7yka1ivTevYXh0qsXTkGu5sOIk0NVmvIDVkTSNFSjI91/7HSi
   sixh9rg4MY/tPxknc7T2yj5ieZnyLpwPFp0TKa+2u/cOZs/qbkEb7G1bP
   CD2HrdWf+xklNyeRpCZAoqF0y10TmEIp+53hR2BUZa/HKMDKAWOGm7PGo
   xMGRDUwdX00K9PGGMy7q1rI8IdzKan3hGD3yYKAZg8BHZmR6brnBQnOlR
   A4QkiQ549/pXpT80wNcJEd4arZAAT86F9dbJqFXEoHxi7xcEkNRTCIV+m
   cbfouUWP9GH3mntlqpInylOCGkBBIxewdKi9AyMPfwns5Nv8+BdBGyzm3
   g==;
X-CSE-ConnectionGUID: kNHd0GE+TNiJwyeCh0nfKg==
X-CSE-MsgGUID: 55vl5ArYRcqPv8E5FoYvqg==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="88286765"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="88286765"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2026 17:50:13 -0700
X-CSE-ConnectionGUID: DJJQviyGT/e8haU1yolVGg==
X-CSE-MsgGUID: Zt2POrffSpSrNPaakUF+Rg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="255756738"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2026 17:50:13 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 13 Jul 2026 17:50:12 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Mon, 13 Jul 2026 17:50:12 -0700
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.42) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 13 Jul 2026 17:50:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QnDT43/coYCSgX1ZM0Hyv6Z1IfIL/JRsYCiYYOVTOQjNAa8i8P3qktLo7DptjUyYZxwQLrLWTH6qG1Iz2y32ZQz0hK019yZFKsGMOGtvrLpT3CR98Btz4jEG1CD1rkpiVJvaX/KjnRRgoq4rXqlEVu0Cjuj66nOdUTNJ6bCPOlqzrCFE/VetI1YT/5jaxP30m7KNZ4eOmUiYIvSoteyp877+ydIG48yGWOJ31ZIaLACN3w5kpU2M07jFWKzkEknueiiZ9FgQ3KPIlD4/bvB/ORU6ie4zDH2OWgYqYgKcTNW+iSac0/ldqztdn8U+a0HmSD83X8AMd8j7bgA74++Mkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7qJaULa4dtz0g/ZnCs30JsXds4CElyTpKmHULTJudzU=;
 b=Os/t65npP6kTlbiVZNmbKObJbw+umXedcyy5Vhyl8aKRS/cmLSfGuCbvVO2WOW5WMve9rCPmZfRVN0siF2PReU/vEMbM2AXP7Tt0fcYuoUOEhYDPVJ/Hp+rucg9HgRrXslXBHsMZWDbm1A94fvBk8oQJTIFrP5m3LgQPxQkIp0/vNjzGvmG2PnYFxO/73IzTwcJrqTjLd0CcE4DAkuOJnHkHv9SJpGgIzF31IHzGxWvK29zxl3BbecjrjiZFFmkvEpCjx3OZDY6g3d/oNdC2A7k01IDnsXXd4Dqfp58kDFgrSPHJr79Z7928v+IfuFK6YDiMCcnShBGFrAylpEp6yA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA1PR11MB6098.namprd11.prod.outlook.com (2603:10b6:208:3d6::20)
 by SA3PR11MB9464.namprd11.prod.outlook.com (2603:10b6:806:464::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.14; Tue, 14 Jul
 2026 00:50:05 +0000
Received: from IA1PR11MB6098.namprd11.prod.outlook.com
 ([fe80::b1d9:3282:7e31:3799]) by IA1PR11MB6098.namprd11.prod.outlook.com
 ([fe80::b1d9:3282:7e31:3799%4]) with mapi id 15.21.0202.014; Tue, 14 Jul 2026
 00:50:04 +0000
From: "Xu, Even" <even.xu@intel.com>
To: Pan Chuang <panchuang@vivo.com>, "Sun, Xinpeng" <xinpeng.sun@intel.com>,
	Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>,
	Sakari Ailus <sakari.ailus@linux.intel.com>, Abhishek Tamboli
	<abhishektamboli9@gmail.com>, Danny D. <d3z.the.dev@gmail.com>, "open
 list:HID CORE LAYER" <linux-input@vger.kernel.org>, open list
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 4/4] HID: Intel-thc-hid: Intel-quickspi: Remove redundant
 dev_err()
Thread-Topic: [PATCH 4/4] HID: Intel-thc-hid: Intel-quickspi: Remove redundant
 dev_err()
Thread-Index: AQHdEssVx07KQqjza0Wz6JQGa+wzTbZsL3tg
Date: Tue, 14 Jul 2026 00:50:04 +0000
Message-ID: <IA1PR11MB60987170F254F4152C1F7C95F4F92@IA1PR11MB6098.namprd11.prod.outlook.com>
References: <20260713132439.380121-1-panchuang@vivo.com>
 <20260713132439.380121-5-panchuang@vivo.com>
In-Reply-To: <20260713132439.380121-5-panchuang@vivo.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR11MB6098:EE_|SA3PR11MB9464:EE_
x-ms-office365-filtering-correlation-id: 7bab3daf-a04e-4afc-184a-08dee141d7ff
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|23010399003|1800799024|38070700021|921020|6133799003|11063799006|56012099006|4143699003|22082099003|18002099003;
x-microsoft-antispam-message-info: QumZ+2MCkEraYGtdbSg+5GwFGPeavZiAdU7Xp6xT+QEFJcQPt7MRpHPFzFagucN1mUgpAgWIBOXFtu90lK83Wez7MwoOxCmM9d5lqzLaN76EkpLZeY37/50vnS5OsYTRqq4tMfNYBzzvNWdlA/olhV97Sv7043EfdFkGH6PrH6OzJ7HGl4ETU96MRLRF40GdzZ5x761l0zSwIgxpBtrWKgS71Rzuzu+lGhE/X5i0HY23iHV7y9AOXIky+NMwdaFXalbrgEYZFzIb+/1nx7bB287IXi/KPnMKxvfl6o8CExg7QOdYVpsxc/b1PqAYpaGU5THhEdUhe3ZJtdssmv4RkOZmAHCS3F/OYU4xWMZF/4et+WkDIfd7twT/4kGRQf/u+95jkZRP6Qc0mEhMkGnqZxxQ27/CFGmc+m5b63qLaD3YvHkNvXHsHb9BZ8DMcgMsPhbDpIkYepJvP/1lUedCo1KhaejNe+WzB6GKCgw4D/jD6te2MYfVYgkuJ+x7xKNmbrqfKl8UikYnd2u9dWNUAt1WKmx6BRgsh5RA3TWIMt5FKgEVF1FtGxHbMyjjfbaYafXJ/Ru7BaVLw/kCUSL3j4pmAVeCfVkMdbpKcwifatYlamHQfJh1C5uwKt4XSu8ru4fzHFKhbo1CAk/o2qCwuUmPOfgdrK7fRpqRY1h9IOSk4SX1S4mDOabqb+HztovC0btXT97ZEiLrWH7/+/1Viv0AgDEqUscEJ1S9OVWicjEFwBpB/RN2IHGXpOBa9Bgs
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6098.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(38070700021)(921020)(6133799003)(11063799006)(56012099006)(4143699003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?DINXxSI/GCr+14Z/dtR6V8wcqc8jtvS0UOOcySSqPY93Qfme0pGBfU/udnOc?=
 =?us-ascii?Q?BYAcK+WA26k9P5qIlhgFTEKTLQYP/psKuX+jYNaukntK0mfZWeIza8NSkxdD?=
 =?us-ascii?Q?qyjqF9qmzMUhxNGF//4J2Rd6JzmK+UqbhvW8dDfjTRSpYSqxI0NZgqRSrj8x?=
 =?us-ascii?Q?u3dV5y9zlzAzlcLgbwvAd2avAIk1omuH4O7m5VwCV8GVJdy+XzXJckl5MU9M?=
 =?us-ascii?Q?zFaABNFti+DDXW0i+9YeiLGwJWlgCxLt6RBmUNO6KhBDbK91IeGUtMJnCbt4?=
 =?us-ascii?Q?8tnpO05vl2EXxtpOQYS1/yLQBmHWahO87eL8w7BlZFUjqJLkXy2+jFRAzHOL?=
 =?us-ascii?Q?MkR6kr+HtwFZZnxB8uAOi+M3/D6qhKCmF8Rhs0YGAXxacm6XacsUq3jvnD9g?=
 =?us-ascii?Q?28ViqgVXvUt2vSryZLZ6lCRpCZg4Mk5XaoMnnifGkKphBsd3g7ubZMRSTN8Z?=
 =?us-ascii?Q?sBH4tBfI+thA92/GcwN4MtcKGwyLSJrXdTKTc918spku4NKAQlQB0rdBtyVP?=
 =?us-ascii?Q?kki1SyUVSwYPxCDrpuWBr/cvI/xBLZASDWrH+fWA2aP2P2FrrhjecKm3OPCc?=
 =?us-ascii?Q?1PdrK4LwPAqx2tq+4fXYwk4rF/A8XTdBQxPzA/DPM7r2I7465LfT8VAkun56?=
 =?us-ascii?Q?yfzOjO8qEbBlccXHykISn6HMVa+8ScTsqU5WieYaEkPo4CgCuq7zDWlpFbNN?=
 =?us-ascii?Q?WNBthouBCJ11irzSiyS3trvK8tPq4x9j5muY6nZpo0c/gfA10gz4EyMq1x7R?=
 =?us-ascii?Q?Cgij72g8j6XwoULmTHl/9O8hsEo+woWRPwcTkwB0z6yijDX2UVfWoFKaWcqq?=
 =?us-ascii?Q?Kx/CjAjZA/4fTmqRPR9N7lKuHYDE5VWtyg6b9wdqRlgQUB+LiMX7AWF7bH9J?=
 =?us-ascii?Q?8pl5Wjf2WJ71JTwL0hJaQgkKjaEZthrDO98U/Yo1aZEkgHqiO+cbDm95/XaU?=
 =?us-ascii?Q?rx6uP2bpaw4keC+NxZd2ywHgyFnIUAKcwRytO6kNvshCcuLTDOKVmUpR0Kub?=
 =?us-ascii?Q?gCgXinAXJgka9wOX5rQJrvWE70cqpW+DeVo6viTKu+k2TiGivJ7WpkmfeZDF?=
 =?us-ascii?Q?tU9+HXDqDDUjQPR9LeqNurqJESpiFBRFHYeuzNopHLIxqtF7Qgxdl1bhG++a?=
 =?us-ascii?Q?52ZKAO54MO5uqlMUfIr238o9Q9PYt4U45FNvG2a7IM8Ei+zMaeJy3MjfxRpX?=
 =?us-ascii?Q?pEMnZQQT3I0BloV8pIrX8xPgFME/rShWSSwDR/SPDlDdQIPIlIWfba4Xybjz?=
 =?us-ascii?Q?JWy7ujMv6YlZ2fqEPVJd9Wyfa6aXMiNLNRhZHiGLYSJChc45n/uyL6zA14Jm?=
 =?us-ascii?Q?S6FQ87eV+2RV+5lo3psn2MIJIaPV27/0JDyVvtBLb0dOBjhct9kO4HU5ig68?=
 =?us-ascii?Q?SN/45cRpN4RuEYKnmmuVd1WLms9alYFhppE7uUxniyiCEzMRBkj9OU6bhfV2?=
 =?us-ascii?Q?cRaLdlosc7N0mRruq3aK8rBIW7cbE+160tEiP2PKZrgo7Sqtp3synpbJLl9h?=
 =?us-ascii?Q?HVzLoWylMYF1ojqh69hBvHzZ+X9jlDpcdMVDPOmDa9NRNu/KknQxdbGvYhoS?=
 =?us-ascii?Q?cP4HRpR/Eb1leoO3vJLGCAElZuZuVAxIXckLAWMTGK8VpW2pkGmJj4VGXCJm?=
 =?us-ascii?Q?MEBiWBp3hpYOS6YeazkMNA8VLMruaPyaolhNakS7n/XUYGN881CW4K21qpyV?=
 =?us-ascii?Q?eJv9VYKC8MKist7d3JYJ9emfE7n8DZpttxjS5myfa2ejzE9q?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: j2eL9lF8ezPWQz+egpkl6+QMohkR/Ec4v17X2ICplm1qmPbn4foLqCrjhtvc+hcAo4jOccTWe9LfYsx0KT7UbTu4F3yQnLK++u6d2hovCgfCYpeAzCea1V8ffkJXhq0QJXyfOHsXEhEk2EH0qJAW1mzvVw4HJjB6GV4EBCOgYByz6kQpoYxsKi1VIDRzFJUxD1PVDAw/ob51fFTU4itue4bXYnf4Okkocf20pfE2tU3nPuY3aOPvQ+dfI8H2LuGgM7UwQWSQc4WxW7UP7UNu83lqudlJAQipspKajyRuNUVH0F2Wr46uHjltZQ2TYHGdfQTM5C9rmRzaGoZnS6KR3Q==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6098.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7bab3daf-a04e-4afc-184a-08dee141d7ff
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jul 2026 00:50:04.5808
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UtUiU51relwJskw+WMlIllBN9w8JwUcCmsdc9iZnXDByubgwrI4hYuXiQnxZaY8AGYK/oGNUKcSCiTlTueG6Lg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB9464
X-OriginatorOrg: intel.com

Thanks for the patch!

If this is the case, can you also do the same change for intel-quicki2c dri=
ver?

Best Regards,
Even Xu

> -----Original Message-----
> From: Pan Chuang <panchuang@vivo.com>
> Sent: Monday, July 13, 2026 9:25 PM
> To: Xu, Even <even.xu@intel.com>; Sun, Xinpeng <xinpeng.sun@intel.com>; J=
iri
> Kosina <jikos@kernel.org>; Benjamin Tissoires <bentiss@kernel.org>; Pan
> Chuang <panchuang@vivo.com>; Sakari Ailus <sakari.ailus@linux.intel.com>;
> Abhishek Tamboli <abhishektamboli9@gmail.com>; Danny D.
> <d3z.the.dev@gmail.com>; open list:HID CORE LAYER <linux-
> input@vger.kernel.org>; open list <linux-kernel@vger.kernel.org>
> Subject: [PATCH 4/4] HID: Intel-thc-hid: Intel-quickspi: Remove redundant
> dev_err()
>=20
> Since commit 55b48e23f5c4 ("genirq/devres: Add error handling in
> devm_request_*_irq()"), devm_request_threaded_irq() automatically logs
> detailed error messages on failure. Remove the now-redundant driver-speci=
fic
> dev_err() calls.
>=20
> Signed-off-by: Pan Chuang <panchuang@vivo.com>
> ---
>  drivers/hid/intel-thc-hid/intel-quickspi/pci-quickspi.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
>=20
> diff --git a/drivers/hid/intel-thc-hid/intel-quickspi/pci-quickspi.c
> b/drivers/hid/intel-thc-hid/intel-quickspi/pci-quickspi.c
> index 4ae2e1718b30..504ef3c842ab 100644
> --- a/drivers/hid/intel-thc-hid/intel-quickspi/pci-quickspi.c
> +++ b/drivers/hid/intel-thc-hid/intel-quickspi/pci-quickspi.c
> @@ -636,11 +636,8 @@ static int quickspi_probe(struct pci_dev *pdev,
>  					quickspi_irq_thread_handler,
>  					IRQF_ONESHOT, KBUILD_MODNAME,
>  					qsdev);
> -	if (ret) {
> -		dev_err(&pdev->dev,
> -			"Failed to request threaded IRQ, irq =3D %d.\n", pdev-
> >irq);
> +	if (ret)
>  		goto dev_deinit;
> -	}
>=20
>  	ret =3D reset_tic(qsdev);
>  	if (ret) {
> --
> 2.34.1

