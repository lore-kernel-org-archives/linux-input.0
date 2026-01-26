Received: from eu-smtp-delivery-101.mimecast.com (eu-smtp-delivery-101.mimecast.com [185.58.86.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AE6A33B6E7
	for <linux-input@vger.kernel.org>; Mon, 26 Jan 2026 16:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.58.86.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769445548; cv=none; b=K0nj23joQEXUlZaEhav+lJghDmejWEui7foS2BVOtfF+MFKjEtpiaz0JfscZK9EV86Mot96Kc7c5EzrpLyN7r9i72odJPy8qemEQKrOnxca2j4RED89XJ8zD3A5MPJ+dJNKDycebuxNPjyXGgC5O/3PUSyp03UyLTl/B/MzOUOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769445548; c=relaxed/simple;
	bh=ug4pFk5p+Kjd6hH1a+Ayky3homSY5hDSNh6mNpIe+J4=;
	h=From:Subject:Date:Message-Id:To:Cc:MIME-Version:Content-Type; b=OpEodksW0B2KCPwTl6qOT66V7jP3NfprvFlxIfxDC0uIkN/gUsaj3ejVOxFkSawJxDHLxdxtki/f3sSOx4C0/WeCR6JqG1cy2PVB9P9q7faFe6epNB6sJZzlXCRriYRCgKyn/w1TiRHG7lh3dS0Bly9K8tyfpaeQ96M4uqH/f4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=touchnetix.com; spf=pass smtp.mailfrom=touchnetix.com; arc=none smtp.client-ip=185.58.86.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=touchnetix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=touchnetix.com
Received: from CWXP265CU010.outbound.protection.outlook.com
 (mail-ukwestazon11022082.outbound.protection.outlook.com [52.101.101.82])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id uk-mta-187-bFMtIZY8OFK5wQnUXdFiDA-1; Mon,
 26 Jan 2026 16:38:57 +0000
X-MC-Unique: bFMtIZY8OFK5wQnUXdFiDA-1
X-Mimecast-MFC-AGG-ID: bFMtIZY8OFK5wQnUXdFiDA_1769445536
Received: from LOYP123MB2701.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:e9::9) by
 LO2P123MB3824.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:12d::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.12; Mon, 26 Jan 2026 16:38:53 +0000
Received: from LOYP123MB2701.GBRP123.PROD.OUTLOOK.COM
 ([fe80::4a94:a629:f86f:40d1]) by LOYP123MB2701.GBRP123.PROD.OUTLOOK.COM
 ([fe80::4a94:a629:f86f:40d1%4]) with mapi id 15.20.9542.010; Mon, 26 Jan 2026
 16:38:53 +0000
From: Andrew Thomas <andrew.thomas@touchnetix.com>
Subject: [PATCH 0/2] Input: add support for aXiom touchscreen controller
 using SPI or I2C
Date: Mon, 26 Jan 2026 16:38:22 +0000
Message-Id: <20260126-axiom-driver-submission3-v1-0-d462c4a608e3@touchnetix.com>
X-B4-Tracking: v=1; b=H4sIAH6Yd2kC/x3MSwqEMBBF0a1IjS1I0iDqVsRB1GdbAz9UoQjBv
 Zvu4R2cm8igAqO2SKS4xGTfcviyoHGJ2xcsU24KLlTOh4rjLfvKk8oFZTuHVexnPjzXTYCPaDA
 6yvxQzHL/113/PC96TFJwagAAAA==
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Henrik Rydberg <rydberg@bitmath.org>
Cc: linux-input@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Andrew Thomas <andrew.thomas@touchnetix.com>, 
 Marco Felsch <m.felsch@pengutronix.de>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1769445534; l=1429;
 i=andrew.thomas@touchnetix.com; s=20260126; h=from:subject:message-id;
 bh=V+iDLqSvoAbt2MZGlXUo42J1Ht86LIU6jETGikj8RuU=;
 b=NRGpXk/hL7m9fNnS6U70nVpT5wNgZ/WXwXmP3MEeVTItsiCQocXama34WhQU2IYq29FHhDTGU
 X73xeNu5cILAJ87lELtPkh2rbuiL4DUoiryGM6yty+kPk8ZPMopgXxF
X-Developer-Key: i=andrew.thomas@touchnetix.com; a=ed25519;
 pk=GtS7O+T7kMl4PPu344KeKG2xlsaHEzDUFLtOqb5JPPg=
X-ClientProxiedBy: LO6P123CA0059.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:310::17) To LOYP123MB2701.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:e9::9)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOYP123MB2701:EE_|LO2P123MB3824:EE_
X-MS-Office365-Filtering-Correlation-Id: f7e46878-7d25-4334-a32a-08de5cf96491
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|52116014|366016|38350700014
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MmtLcDZDRm0vcWN4bXcwR3ovTmdMdVVHVXY1ek5ZN0xUMjF1QWR3Ui9XNUpq?=
 =?utf-8?B?SkUrUE5zR1ZYSWxIZHI4bEYwS3k1OGVFSGNoMmYwdENJaVA3Ky9UcFBaRzZx?=
 =?utf-8?B?QzRBWWZsU2dsR3RXOFg4UHArUnkxUFVvQ04wY0VneHJSdVVSaFlwaXgvTjE3?=
 =?utf-8?B?NWdNcG1uTHV6RmdYWitmNHRVNm1YOUxPSHZmNFVBVjl2T29mT0k0NGU4eE9z?=
 =?utf-8?B?NExJQTN1VWdNQUxZN1hPeVB5bDVvK1hPSmc4dElkdGt4dGduN09pZUNWZXRu?=
 =?utf-8?B?UzlkY1h2YmZQNzlsdGJJTGI2VkdWWGJjYVBXT1JNTjFYVmRGQXdDK0QxcDAr?=
 =?utf-8?B?RUs0TFlScm5admZHeG9aN2hFR1Y5RHJneExiOEtLczk3SlpmTSs1eDFIeFhM?=
 =?utf-8?B?UjZKdnZIWnI1cFo5ZnV0SUUxWWtSWDZVeGRLTEZVYisxYjg0Mlg2cjZuM25Q?=
 =?utf-8?B?UU1SdGdrcGxhSnhRaUU5MjZKNzdnZlhiODNmTkJsdm8zeGE0WU51SWtIOUVF?=
 =?utf-8?B?TlEwNWVBeWg2Q1JLTlA4dlJKYWU3VzQrWmFHd0RGSlNFWCt1OUZxM0JhY2d3?=
 =?utf-8?B?Q3lNd29iVUcraitBRTJ0cnYvWFEyUlYzZDhMbHpZalFXYkVCSTRuUjlTZWZO?=
 =?utf-8?B?VGlSMUxXMDZtTFJYb1FoSVJTZnVFWU0wT3lXUlJOS1hkQlAzTy9OeDV3VjQ1?=
 =?utf-8?B?K0hmSTZDak9tQWNzSlZpYW1Yc3F6THozclZ1VGUvWDIxMUxXc0ZCNk40NFQ0?=
 =?utf-8?B?bERxWmJhbkZCdkJaTkkwVGs2YllsOXhLY2hWcVFucHliN0JqSDhBMFBQRGlS?=
 =?utf-8?B?WUxrL2VNQzZ6TE1GOFV5Qm9BaCtiSk12VXNySzRWaEVJUFRmSmQ4UXYyYzJq?=
 =?utf-8?B?VlY2MEZZdTMwTFJtMVJoaE1VNHd4YUxiODJKWllTRlZXRnlaWEowM29qRlZs?=
 =?utf-8?B?V0c5REJXNnl2WFVtUkNVMmp1SzN1MFB3clV3QVJOTzVrVTNvK25zL2MyWHlp?=
 =?utf-8?B?TnVaOWx1Q0ZKL3luenlIZ1NFd0RjZ0t5bndmRkFRWllFWGhCSUZLWmxVVU1P?=
 =?utf-8?B?Qm9lRFVQRlVxU1FrcWh4YW1vRmdWYVV0TjIvMHZ5RmNIc3VFNGk3SG5RQ2ty?=
 =?utf-8?B?Y3ZvbnV0NFYwWHRTSVdjZ3dxa0NuSE9iOTNZUnpuSDlKaTdmR2xobzVPUTQ1?=
 =?utf-8?B?OHR0OFh2L29JZzQzbzhkdHdJZ1JTR2lFeWlZdXJOTFJ0U3h6VXNJQ0FBZ2c2?=
 =?utf-8?B?dHIybjhuaTNJM2hpV3BqYnlJNDY2Rm9JUU1QTU5BQzVIZ0ZiVHRpYXlXem1m?=
 =?utf-8?B?N0FuUW5ycVRSb2tFZ005Z1NIRkQyK1lBR1NUTXZHRXFhME43R3VZcks4K3Vv?=
 =?utf-8?B?ZDA1WSs2d2kySi9FcFFYa1BnV0dEakoyN0d2REVLanFyOWhMeU4vWkE4dTVS?=
 =?utf-8?B?bHZ4czcxSkxRbitzeUNUWmZoYm1QNEd3NnhNQ2tQQU9TSlpuYUJxaFhLbytr?=
 =?utf-8?B?TnlQZGtabXJjdjNVNXFZTGUyZmFWQTVlUk5zd2tFVzFxQXV4aGRNcW5iNGhK?=
 =?utf-8?B?S080Tm1RaG50Nm1OY2cvQUF6K2YyYXVIbS9pcDYvU2JWdkVUd2piWGxycXNX?=
 =?utf-8?B?NDlZcnh0bTJpbHRsTURCNy9Tb3dWODFWNW10WWZPWXhCTEV3bGtNK1ZnNlNo?=
 =?utf-8?B?bzlKM2dRbTVJTDEzL0Faa21EcTl5M1lMWUJ5T2VLd1hiVFZGMkZGaEJGWVlC?=
 =?utf-8?B?OWpoNWk0UFZIOGdwRVBtMEhhbEo0OTdxU0F5cGxMajkxMFBvQzdPYmdwMjdK?=
 =?utf-8?B?SnVmOE9JVE5rU3I2M2Y4TXpmaVVRUHBlY2FoTitsZDJ6bzNoNTFNb3pjR2dP?=
 =?utf-8?B?WUR1YkNMelpIY3drL3E2T2swbU9hazUrV0dvdUR3dEhqVWh0N0lMK3dMT0dB?=
 =?utf-8?B?cC9OdDJkcUIwR0pHY3M1QlVxL0k3d0FGYXJTZ3JsR1ZxUElab2VjeWxGbVAv?=
 =?utf-8?B?MXhlRTIxTVh6RWwyMjFqUU9EWWN0RHdLeGlpSmFEUmZJVWJoRE5hR2xQOVpH?=
 =?utf-8?B?eG9KT2kzcllUdGNXTG9TZjRnb1pkYVMzeDYvbDVPWXZDeTBYbm9NWUJMQUFi?=
 =?utf-8?B?QTV1NDBqKzJ4OXl2QmRGQkIrb2xUeUQxQ1dKNzhobXQycVk4REJWOXJyajJB?=
 =?utf-8?Q?T4WeeB/vX+FjSC5xKxjm6U8=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOYP123MB2701.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(52116014)(366016)(38350700014);DIR:OUT;SFP:1102
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YXY5dTJ3VVhrc3g5RlZBTDJlOWpxV1huVW1jSU1OeGNvYktqcURsamNZbzlK?=
 =?utf-8?B?K1hJY3Zib1VjclJDUHBnWXc5TjhjZjhaaEpMM1l4OHNsa0hTekxjbGhHRStW?=
 =?utf-8?B?SWlGVzFDYmJ4YXZuenZSTnlOL0xWb2UzcHpkWlU3cGZxQkwvUldNaDhvS3I5?=
 =?utf-8?B?VTFxZU41MmZ0Y05ycUVwb3k2OW1rTTlkTWxGWU13YWE1bk9QMG5TdDkzaGl1?=
 =?utf-8?B?NzJQa0lrL3pPTGgzMHAwYWZIZXQwdmxNVXdLaGJTSVplYmZUQ1k4NnViV3hS?=
 =?utf-8?B?QnVNMkdPaDN0aEIrS1h5MVJpUnlTR2VoZml1ZWZNd3Vtb2s2S04wQW9nbEtk?=
 =?utf-8?B?MUoyS0ZiU3M3RnJnNCt5dUJnWjR3c29pc0Z3OGtmM01pa1g4ZU9wc0xwbGlY?=
 =?utf-8?B?OEl1RlpjYk1TV0I5MGxPK2F4N3VJbXRJaXVTcGNsWVZnb2s5RzFXamMyYmQ3?=
 =?utf-8?B?a0dDUzlqY3FaemN1NlJDVDluemN1SnpsZ2RXTTYxWHQ4Q0M0UUxpbjBsTUlO?=
 =?utf-8?B?M1pZT1J0bk5Cbm93MlNvbVR0NVEySEVRY25ldVNEalpHTkY0VnBCaFVMN3Ex?=
 =?utf-8?B?bVRxT0RobkdoTVJIb3FNemZiQzdSMGJQZEtqNkh5VDlyWDZoRkhnYk1lMHN5?=
 =?utf-8?B?ME1DdkU2V0swcFJ4bVNsUnhUemdVOTlYVDhiV3lTQjhaQ0l2aEhlYXVUS3Y3?=
 =?utf-8?B?ZXEzNW1iMWh4N2NrQUZvVE15Wms0MGI1MmZ0L3Y0YndtSWttME1tY1lqaVlK?=
 =?utf-8?B?d3haNVkxWmNjOGd0ZXk4eXY3M3pEM3l0dkdEeDVPTUhFeDNBdEFTSWR5SkFX?=
 =?utf-8?B?d0J1SCtZOUVTZ0wveVJ3ZjZ6N3dsK0srMFV0QkdLMUpFaC9NMHRJVk5Xc2RR?=
 =?utf-8?B?Si9WdmtzVnkyMEdhdG14aVNyU0R5emRwNlRpN09mVjdxVVFTcE9QSVkvWG9p?=
 =?utf-8?B?Z2JIZjY0WGxJL3JYdU96ekNRZk9CdWU2b3NJK0NRQ2p1VDdrNEhENmdCMDJj?=
 =?utf-8?B?VGhvaUdDMXdET0VEekloSStsY29RaGhNSWVNTk1JZDBvY3Y3eHZkbmZNR1VP?=
 =?utf-8?B?SENsdnF0SFk5MU1BUWpoZEtlV0ZnUllvYkpRUHhydHp1ZUhiRTlGR1Q5OGFE?=
 =?utf-8?B?VlN0dmFPTEUxN3FKYjhBN2k1ZE5zcHJEaHl1Y0tmU1o2a0FzMjgzVVFBYk1k?=
 =?utf-8?B?V3FlNmJPeFBOUkwzQ3Byd1RhNWpnaXMzTTloSHIwMU1ORzZrYkQ0c0oveVNT?=
 =?utf-8?B?bEEyMEdqVlNCQ1E2RlNOZzJyeGNEaG5zMU8yWmhNT2UrWU5GT0t1UFhSTGdT?=
 =?utf-8?B?cVIyZlJxN0o3MVhGZ1U0SkpLakhUUmJvODh2ZVhoOVh3bzJWZGpDc1dBei9z?=
 =?utf-8?B?V0VJRS9sM2pIbkVUbGZEZ3NHQjludEw5b1pOSjg4UjlyTFFmM2x6MTc5YmF2?=
 =?utf-8?B?bGUreGFMSW55cFl1bHRlbmRoT2lKTmd0cHZQQXRUS3k3Y091cFl1eEFYK1p2?=
 =?utf-8?B?Sy9ST2tPWEVsVzI1cGdmaW1SUnlNbC9BdjJXNmptcERYYUdZNXpvcVdRNjdT?=
 =?utf-8?B?RTVGZVNKUzhNREQ2S0pJUXBJTXRYdXorbW12RldoRVNuRUplcmRJbEFHZ0dm?=
 =?utf-8?B?dklwbWhma04yLzJURkxjSTREcmVkQUN1bVk0UUJmRjdCeUlSZStxYWxkQWQz?=
 =?utf-8?B?REV2ekxjVm9oTkd3WEQrZ0NwajRQRTVaNHQvbWtLeFpJRzg2OXczUkdEd2lE?=
 =?utf-8?B?Tjc1eEVXbUdSd3V5ZU1zSU5tSElPb0RqaHZmRGFZUmdjU0cxdlpDS2hsU2Zl?=
 =?utf-8?B?RXdTWkYreDBMRDNSWWpNd25NVjN5a2dNcUl4WnRjbGMxY0FKY1FWRWtiMm1i?=
 =?utf-8?B?cVA1Wis3RC82RFRNdHRZV2ZGYlFQNmkxTE1sTUdESW1xL0dRM3E5T3lQY2hD?=
 =?utf-8?B?NkJlMmtiYm4zc2U5am1helV5SGZtOVF6cURNY0x6Q3JXc1I2UHZxeENwV3NM?=
 =?utf-8?B?YXIrU1BKM0hCUTVkd0dCWEViVnFQRkVPSk5uM0NabHViais5Z1pxZE1hOURM?=
 =?utf-8?B?K20vRmZNUmgvYnUyN1BINVpVN1hORFczcHVjWUxLb1JncFpuV2pHeVozZ2pZ?=
 =?utf-8?B?VUNXVDBOTHBENGJsUDIrWWtxenFoU043Um1MQTJsd0Y1KzF5U0lyY1RWVmt2?=
 =?utf-8?B?ZU1OVVNiK3JDR0RqZmxTZjRSY2w0OE9QVDJrVkJ1dUZlbDNlWTk3QmhSRHJE?=
 =?utf-8?B?SjZ5YVBGZkQvWVlaZTlqcXYwMXZkZGVvSEJKeVZ3STBKU0EwMW5ETXc2am96?=
 =?utf-8?B?RFk2TlpOZFh3SEs5NXpqRnpnazJ1YmcwNXZDeE81WGwvZ21oODZMT0NyY1Mx?=
 =?utf-8?Q?nuU1ZmI1g01l98t4=3D?=
X-OriginatorOrg: touchnetix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7e46878-7d25-4334-a32a-08de5cf96491
X-MS-Exchange-CrossTenant-AuthSource: LOYP123MB2701.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2026 16:38:53.7891
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 120474da-7cc3-44b9-aff9-438a33341070
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IJpZb2TvHqfJi4l26JKobbYjo55yL6n0Lz/AL0+tYYfZfCp79WhR/Jw/GmM37gipjyrgOOmBaKpVTdbYtHgSdjHq9MUJAdhauAU2egLXBOo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO2P123MB3824
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: hxgSG3T2lw2yEddvWkWEk97muNlau61zaKGNr-JkxsI_1769445536
X-Mimecast-Originator: touchnetix.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Summary of the added features:
 - Add input driver support for TouchNetix aXiom touchscreen controller
using either I2C or SPI.
 - Support ABS_MT touch reports in axiom_process_u41_report().
 - Support both polling and interrupt mode.
 - Add basic documentation and provide example device tree bindings.
 - Provide the basic structure to add firmware and config download in
the future via both I2C and SPI.

Many thanks,
Andrew

Signed-off-by: Andrew Thomas <andrew.thomas@touchnetix.com>
---
Andrew Thomas (2):
      dt-bindings: input: touchscreen: add TouchNetix aXiom device tree
      Input: add support for aXiom touchscreen controller using SPI or I2C

 .../bindings/input/touchscreen/tnx,axiom.yaml      |  70 +++
 .../devicetree/bindings/vendor-prefixes.yaml       |   2 +
 drivers/input/touchscreen/Kconfig                  |  25 ++
 drivers/input/touchscreen/Makefile                 |   3 +
 drivers/input/touchscreen/axiom_core.c             | 473 +++++++++++++++++=
++++
 drivers/input/touchscreen/axiom_core.h             | 118 +++++
 drivers/input/touchscreen/axiom_i2c.c              | 150 +++++++
 drivers/input/touchscreen/axiom_spi.c              | 155 +++++++
 8 files changed, 996 insertions(+)
---
base-commit: 7ff574599464bd0e30da88aabc7be9de1021204a
change-id: 20260126-axiom-driver-submission3-f892e1ae9ec0

Best regards,
--=20
Andrew Thomas <andrew.thomas@touchnetix.com>

