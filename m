Received: from eu-smtp-delivery-101.mimecast.com (eu-smtp-delivery-101.mimecast.com [185.58.86.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F06D2E5B19
	for <linux-input@vger.kernel.org>; Thu, 22 Jan 2026 12:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.58.86.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769086204; cv=none; b=PWHJ8rI8gsF5NBskBUGZOgMbur/o7C2hE6F9LRqPncNOA1/Nu7up0hwRhmpQsH+eNtHphNjMHN16MmwD17LXQS2u9dwrR0szt3GYX7Y18C9q6lm7muRkvzl8Qh8WhUPJqfDdmu4nlKnkOkdrwuRpwp7xSLsqZtkeDqlEOoRFaY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769086204; c=relaxed/simple;
	bh=PU1TRcM10Xe6jvaghYaGDssEeaiTlzLMW1awbRlkj4I=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=k5gDp19gEl3dALV8aJSiEOOFr3c+wcS6MxbSTVCy0i3JLMTX1OnS57bU2BeMoY9dJph887+T7DIDWlOgyxDOxzHv+bvIIGcaevNM8l9xkzSSVZp7Xa4Bgq6WnfpQFzcL57Fgn44RXWQhlncV2g+z9B+tDV5XrvAaCYHHQeJfdac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=touchnetix.com; spf=pass smtp.mailfrom=touchnetix.com; arc=none smtp.client-ip=185.58.86.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=touchnetix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=touchnetix.com
Received: from CWXP265CU009.outbound.protection.outlook.com
 (mail-ukwestazon11021087.outbound.protection.outlook.com [52.101.100.87])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id uk-mta-227-vY5HOPW0Ns-ivCd2WYgDvA-1; Thu,
 22 Jan 2026 12:48:33 +0000
X-MC-Unique: vY5HOPW0Ns-ivCd2WYgDvA-1
X-Mimecast-MFC-AGG-ID: vY5HOPW0Ns-ivCd2WYgDvA_1769086112
Received: from LOYP123MB2701.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:e9::9) by
 LOAP123MB8292.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:43b::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.11; Thu, 22 Jan 2026 12:48:31 +0000
Received: from LOYP123MB2701.GBRP123.PROD.OUTLOOK.COM
 ([fe80::4a94:a629:f86f:40d1]) by LOYP123MB2701.GBRP123.PROD.OUTLOOK.COM
 ([fe80::4a94:a629:f86f:40d1%4]) with mapi id 15.20.9542.009; Thu, 22 Jan 2026
 12:48:31 +0000
From: AThomas63 <andrew.thomas@touchnetix.com>
To: dmitry.torokhov@gmail.com
CC: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	mark.satterthwaite@touchnetix.com,
	andrew.thomas@touchnetix.com,
	m.felsch@pengutronix.de,
	kamel.bouhara@bootlin.com
Subject: [PATCH 0/1] Input: Add TouchNetix aXiom touchscreen driver
Date: Thu, 22 Jan 2026 12:48:18 +0000
Message-ID: <20260122124819.273188-1-andrew.thomas@touchnetix.com>
X-Mailer: git-send-email 2.43.0
X-ClientProxiedBy: LO4P265CA0031.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2ae::7) To LOYP123MB2701.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:e9::9)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOYP123MB2701:EE_|LOAP123MB8292:EE_
X-MS-Office365-Filtering-Correlation-Id: 4547e865-601e-40e2-5d93-08de59b48bcc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|52116014|376014|1800799024|366016|38350700014
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?1PB0+aV65XGTIpOo17lGw5MzoSBwuDQ/Vl5EUbivJw4Wch1Hjl8tF7T364Da?=
 =?us-ascii?Q?n2TmujGIDy6CdZOgL5UOzY/I57stCTKJEq/hJpS7NJmSCeZ9rfTMb8obH/9e?=
 =?us-ascii?Q?QEKCg8gbAvN5301DTfhOTMpCOpO8oVO9Aj6f/wIVIgJVSXRjfvSQYA1KrCL0?=
 =?us-ascii?Q?+PBn/0NEZKFYIffXnkIAwsimVfzUkzqcxJL4pAyJzqlElGhEI3XYRP4ttZrs?=
 =?us-ascii?Q?P9WZsL8h1uVDVSH4yaj8ayn2nJO99d/Ome/djIwMMldakz0iE2Jq695qoH/x?=
 =?us-ascii?Q?aelV2zb5eTHqw13Z+iZIQ94Kh7w3hxYl2QxdAOLgM/5hRFR/cwxRt0ch8Jir?=
 =?us-ascii?Q?NxziXxIW86hDKj2rBmR860S0GAjYliBSez/q9/++oXS0bde1NNRmdfcR6WsR?=
 =?us-ascii?Q?lOEVwdNM9JQt5ajPce75gkJS6gHH16BVGDh22YaOuZQi7KOKvLw4DJB83mLR?=
 =?us-ascii?Q?7omc6yOOACkxLGqXhhrnO1OlC9w5o3Oc+l4lk9mReOrPjAk4u09pHnGtC+oa?=
 =?us-ascii?Q?hcXr1aMUP+3PIkBAKOrZrXcEs26Y7K9RW35jZ05CrnvU8/JKDz01MQyh0uPh?=
 =?us-ascii?Q?RWJdROtVCXVUXYAsi+qWHr9YX/KWr/SZgg9A9IDkWgKg7n8hjcq9cyPGCM1g?=
 =?us-ascii?Q?EjAgNoRky8cRPAXFHIYiRn/a1sas/EFdujHshELVC9fvFqXaYhT2igPlg0Yc?=
 =?us-ascii?Q?g3uvhcufISmsrDX/gKcQyjTgvkZj+/wFqgJz5xeTW82eJloF8VRL2ioqT7/o?=
 =?us-ascii?Q?rD6VHCZbFM2uwodgoW+4n1mIuAntcZ8NI33b09bkSxFt9qkjElv4LworLFSh?=
 =?us-ascii?Q?VJ0T5X4nsRhehle/NPRvxeXf4bD9QAFfZaVsiraie87q99Q2WfVE8QcDE/Ho?=
 =?us-ascii?Q?Os9ytR6Bg7ByTVfU03o6R0C8KgCO4f9+7VpsiTUYk36TJmagTSKzJQ7BsD+X?=
 =?us-ascii?Q?Sq0HAITrWSRINGEFFuiwyN4waRxmgu9ZgjrXZocaKWZL1fR42RZF8Ha3PEef?=
 =?us-ascii?Q?uFAhhKK1Sn6HnTcNeiD/Tf+++UHIQAeU5SiufKgaQGxdAXxLmUAWG4bO6K7F?=
 =?us-ascii?Q?LLaZyyQsgUIo0rRMPyZlJh8gUG7YcGJsOnkC79dYztyh8eo+97l5n2HWKolI?=
 =?us-ascii?Q?lybf6amnAdr4KAYFF7Tz5CSUv/QvgPOCrtxUjYQEYk3EHjlE9UXsk/FEUqDY?=
 =?us-ascii?Q?SpL8Lp5qC3lzO82PrFwGaESvnSFwhVOCUFpcMAApUQRa4dt9mDiS2todqR0L?=
 =?us-ascii?Q?8nchHIAsqrNT7IVHp1f8qn1hvy7fB0fEx4swBPzFhPaFoUiQuGntnqnQT1oJ?=
 =?us-ascii?Q?3pBZdtr7M7XMmaMolBNYWX6lBuQpLBxnCbuLUDKgQUocuG+4CHVES4Swr8gy?=
 =?us-ascii?Q?kYzvkLLNAItqakX8/KUjpOqUS6/ajlZs4szJ27knjIy5kmbSSOeZOe9b10Md?=
 =?us-ascii?Q?D8NLJ+8fgek+dzO9XFIvxQsOSzqyQTNw43JDzjg1PoXg3uBUNE0qC1RrfQRF?=
 =?us-ascii?Q?Kcf51FNKS9xJHLcZyzZKybWwDGG9FH5MNdt6hUwbUcWT3JG+EFu8l2qtGCYA?=
 =?us-ascii?Q?8Om5L+fs6MUnN/cxeZor4JePhW9liLBb2XlBxwKV3kZbh8h8sbo8ew1bEiYJ?=
 =?us-ascii?Q?85+dz7Se2T5o4WxU3fNiiQk=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOYP123MB2701.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1102
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?TsrTGnBHRdHcSwh3y/QBykszomp0VTbKaKujLg77XIMY+FV7qqR1VZUh12nM?=
 =?us-ascii?Q?JyQ7lHhTfiuuUsOCKxZbqdEOeWoSK5EG/NNW7BbuuHWQv4+D/HWxTS6UevwZ?=
 =?us-ascii?Q?dwqjixWn3QTV+FsUtNpyGCucPztl7WeaFzeZI6smIJP0ul/aNAQqZDWbPnBx?=
 =?us-ascii?Q?vJcRydqA21eq32S8Q9T68Shz2O9RNGdA7Gmg/kkaAVsjr9yw59BDv74ninFD?=
 =?us-ascii?Q?GdklIEpwc2TzG4QaP+XqHIBTU/xDxq2xT/O/h1dH9yiYKylgAq5cBRkDlTxI?=
 =?us-ascii?Q?SkE22b0D0vbMv7ryvMTbBVu4oPXKka+iIPjxTz8hncxLJzLecRvTBR1vS5IB?=
 =?us-ascii?Q?qhZ7q+cUfJaISzqmQo06TeMuvPrdQhWjmM3NnSKbzgKlgWxqQ2SyhwekWqBa?=
 =?us-ascii?Q?Dkl0BUr2NTYYXINds78FNJD7EeC8k7pZXo18hbkPZoXeHx7fpn84sRmBiICx?=
 =?us-ascii?Q?NK7Ol5Dj9pGvI2HdUnQBG6GYocG4z1empFX2QeNnX5VXPiuihhFrkpMNphD4?=
 =?us-ascii?Q?/QvgDyFZw2STtxrXOWImX/DqTYC/RwiVwLqnKE7E6ksCoTqB82BRLn2os2AB?=
 =?us-ascii?Q?l4bPL99l5H/ojiixCnT7rwPyDjUNEwVyFY4rDrakzh8ZMI/YUL7Hn+g5CSHv?=
 =?us-ascii?Q?3Qu+v7aw+jdrmQh/V/d+sc5ImKUehUDY8PmWnLL1rTHVNSCpk2LJzaYpYc7R?=
 =?us-ascii?Q?WG7ECLrRMkzAVS7wm2xpuRLRcQDi0JFGSCbI5/HrUNvt+S6CY4NU39vcbP9C?=
 =?us-ascii?Q?+bXNPe4uNMaSisLzaTrxOsoqHats65baLuh8doVhB4GQey0sU8W74GEffhK5?=
 =?us-ascii?Q?r7MPoXstbLPdsUcw2+GQVExoUGCsHs6sH65Y0CGFqc1in9NprAaIt5S9BoBU?=
 =?us-ascii?Q?sTQH1Zm5bzxXceIq1Sx08npAoRzBQ2fE0MZb2zqWit7BrIKIJakAiXbG2vAu?=
 =?us-ascii?Q?NygN0ZJg0rm0lPXsTGiWxh1dGvHKNvpCW4drI615hiA4qbnVLNhXnNRpn5BS?=
 =?us-ascii?Q?81OksITuNDUYBLE8zIiyU6RJDgxQXu6xcKVhVVtDUXofHnF6EZRtnzJuWnSq?=
 =?us-ascii?Q?DswG+Mt2tpILfMLcsWgI8gqH+7MwjMsWGNKpKB5rzoc2UK5XzIZF6NYBVbaH?=
 =?us-ascii?Q?qOfurTfFChB1LQizBBHeLI8rEv7EtxlR+seI9HsoUUKJDNA43WYB1L10j9/N?=
 =?us-ascii?Q?RCcl+kU9fqF2oVdee3udD9+nulGOw+h9ouAZFG520HS3yms8AkPqxBCg0BUD?=
 =?us-ascii?Q?FSUXbodlSdbi2Z58PzY7I6DbuVR1gBQGKv2WHs6eFPogaMrXjkT8UJ/XjVlN?=
 =?us-ascii?Q?0nw2TA/0uRhxMm0E7R4qCWgUaqTppdCBmjZ1fo6SyeTEZ6NYFdA2U1BzQbYB?=
 =?us-ascii?Q?QKPd+3nueuU8ut9vwfHc5fXHDZpS/ZqYOZxf7TWKcOcPsWo9cZv2ghK9scFT?=
 =?us-ascii?Q?oD6IGJLOWBh2xqvtOFW7dYHldqanRVbXTQm+OJ+xEI2ay7g8lRSxYLiMCPKp?=
 =?us-ascii?Q?3EcyY31yBzotImNnwoJv3V1GIKTDk1fB4BKPzs+FgAhhcXMZyAPLbOgrPf+m?=
 =?us-ascii?Q?I01twBZeDJxgQ4O60DXBCOEQcsA9jn3I8gQjVzCd0opxrY/XBtnK26Uou35y?=
 =?us-ascii?Q?2J7zvKocuS3Gmv9nntMg77KliPJB1/m7Y4i34tvJxP2w9mhvKMp67wqoSdO+?=
 =?us-ascii?Q?HNN1H9OgxXFE5ooe5pPiZGxXv6QSLKpfqeLisJ6Xfs/a9ECAVCAngrTH6HlX?=
 =?us-ascii?Q?xJFiF74peASLsuQSdCKfxhG8Bc2a9Ec=3D?=
X-OriginatorOrg: touchnetix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4547e865-601e-40e2-5d93-08de59b48bcc
X-MS-Exchange-CrossTenant-AuthSource: LOYP123MB2701.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2026 12:48:30.9916
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 120474da-7cc3-44b9-aff9-438a33341070
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W4SxNbzizhBl4haWJ0yw2uF624daEw/aH1lD8OHj73OiAwpt9WJankJpbt+ng3jS2Ea+DxGVH1h1PMMdw/Sn5B361qNe8v00LxSXleEFrWc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LOAP123MB8292
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: NwLjXsNumcdttv22AB3iZvUKN5hQR_hQ4tUJ-Ex4jys_1769086112
X-Mimecast-Originator: touchnetix.com
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=WINDOWS-1252

A Summary of the added features:
 - Add input driver support for TouchNetix aXiom touchscreen controller=20
using either I2C or SPI.
 - Support ABS_MT touch reports in axiom_process_u41_report().
 - Support both polling and interrupt mode (trigger low).
 - Add basic documentation and provide example device tree bindings.
 - Provide the basic structure to add firmware and config download in
the future via both I2C and SPI.

I understand the process is already under way to add a driver to support=20
aXiom by Marco at Pengutronix.
I think it would be most useful for us to attempt to combine this patch
in order to support both his changes for config/firmware download and=20
the patch here for SPI support along with I2C. I would be happy to help=20
with this process.
This would allow TouchNetix to support a broader range of users of the
aXiom device family.

I also have a device tree binding however I have not added it sincec
from my understanding this should go in a different patch:
Documentation/devicetree/bindings/input/touchscreen/tnx,axiom.yaml
=20
My apologies if there are any obvious mistakes in this patch, this is the
first patch that I have submitted.

Many thanks for your time,
Andrew Thomas

AThomas63 (1):
  Adding support for aXiom touchscreen controller

 drivers/input/touchscreen/Kconfig      |  30 ++
 drivers/input/touchscreen/Makefile     |   3 +
 drivers/input/touchscreen/axiom_core.c | 482 +++++++++++++++++++++++++
 drivers/input/touchscreen/axiom_core.h | 128 +++++++
 drivers/input/touchscreen/axiom_i2c.c  | 152 ++++++++
 drivers/input/touchscreen/axiom_spi.c  | 159 ++++++++
 6 files changed, 954 insertions(+)
 create mode 100644 drivers/input/touchscreen/axiom_core.c
 create mode 100644 drivers/input/touchscreen/axiom_core.h
 create mode 100644 drivers/input/touchscreen/axiom_i2c.c
 create mode 100644 drivers/input/touchscreen/axiom_spi.c

--=20
2.43.0

