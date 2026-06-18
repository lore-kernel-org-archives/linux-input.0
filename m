Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013033.outbound.protection.outlook.com [40.107.159.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECBAE3C9894;
	Thu, 18 Jun 2026 07:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781767763; cv=fail; b=M3ce/FLPW3j2VbHmZIPI4Mf2xeD8Fj6EzdQf8V/BsomL8x66fylIEVGAzroQf81gUunlj0vgs46smZNvNzEijiL/rsfCX+1Ez0ZJLa+oI+CFT0oQtpnjF98ywoLrEzsXPz04cjVpJpw1lJKlRy7DTBzFdHHNYerQuLJ1Q0cIGvE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781767763; c=relaxed/simple;
	bh=AJQEKIoi2VhwpW49EK4+vD/T1pJyv4+nKZ8qkOyWGH0=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=c+Ry9y0QK6FWJlmC+ngWzMy1vWYT9nAbrZNWIrJ2zR9k5vx2LS+jHASWc0nnon1ArVAnngk2q6OOlByPhwpW2lNFj22RE92GK4EO8RsXNnr5IvDcKceUlvGH+jVjwPQLCBlPJ6BIXGKjP6ntrLWsVatULzkx+HLL6bX2UN7Q9Nw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=FP9+wxR8; arc=fail smtp.client-ip=40.107.159.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="FP9+wxR8"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tIE03nWil09HgEJ4GRoRe4lHF3yYeFQay6/5IzJapMVoO8fhqEXSYErCpoCqlw+mv7MWbnAWp7gqiZhI+ZqmlSPq1oGfplijZFDXu5BNmwkSoeHSW9JSLNsyYksbXihFT0XEbn9rbXuqPtome/VmSgceEQFqaHUB7IBbxtcpuuLJ6qjsqz/0X3LV0PcVJT0rQ1aE8myelL1Tq5QVlADPPfAbufKjRTj3AgTxgaI4m8tAKcQQLwwcMUaHRWiK1HFwx6mOiMVrcHC2s0x1tdiGckKGtS03y4g1eXECoHafw+cE9HnpuOdu/nbvNSZdHrQPWPNkTtMiz4Z7eknSfRhUKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L6YuZnggeGpAV9lnymgHDVsZ4OhqISVjDOmgKLpBagI=;
 b=iJndrB6q1kqmj4gToU9xT2+AmYQ3apJr9YMiUPlUVrj1RjEqCzu4vLPUPSRd66ybvMPERAcg7KmnPAe86ApYwV+idC1X1HPWshTmzg0ug07N38u2Nsk6g8up1+QrAbAHC87ILHT6iyz3dXuQlPRzLVD+je2j2O2b3iK4k6aFhVndi4cX7k2oeIZ/fswVopGCJTm4URQtMoVvh3pqV1zYQ/LfjhIRFUry4l7Arp2NrVuNzYvnlPX+mj329lZa+Z4eaNhV89xYMaF2OoRuWsEXxnm6c1kRrA3gMgtmhZE1R33PfFHFK/HrUUfcSW/Qx2N1LURRd9HvWav20NyzZOoq6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L6YuZnggeGpAV9lnymgHDVsZ4OhqISVjDOmgKLpBagI=;
 b=FP9+wxR8glCYQPs5VFkOGRysqeJM8Y7zeHGLE0bxEuMKZhP9fqyTv1wbiw8TC98SizViYmfmK3Oru55oQyyPs/usn4YJhh56MqN6Ke/6ASf4EeFBjv5XrMBUl09tlEwp8NQuaDMD7X9SYqzPiV0B7NU9Js0WpFW1xXy69NVYmEXaeCccP89we8+tFrYFfzIBf/fwBqix5QdPy000al7n4goVyDwU6pf+NsozspwmBTrx3/aZ9ma5ybxqdpXIdQQiOEDdCVlD0US52dZJy/CkWFXcPyzpP2TZGMR33jySrdY/fOnTk0i6DyNcBH/Tk+qL4G50TuPqHIF9x3c7XsphAg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VI1PR04MB5807.eurprd04.prod.outlook.com (2603:10a6:803:ec::21)
 by PA2PR04MB10157.eurprd04.prod.outlook.com (2603:10a6:102:409::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Thu, 18 Jun
 2026 07:29:18 +0000
Received: from VI1PR04MB5807.eurprd04.prod.outlook.com
 ([fe80::3da4:2827:d637:37de]) by VI1PR04MB5807.eurprd04.prod.outlook.com
 ([fe80::3da4:2827:d637:37de%4]) with mapi id 15.21.0113.015; Thu, 18 Jun 2026
 07:29:17 +0000
From: joy.zou@oss.nxp.com
Date: Thu, 18 Jun 2026 15:31:48 +0800
Subject: [PATCH v4 3/4] Input: snvs_pwrkey - use local device pointer to
 simple code
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260618-b4-pwrkey-v4-3-4bfda105bdf3@oss.nxp.com>
References: <20260618-b4-pwrkey-v4-0-4bfda105bdf3@oss.nxp.com>
In-Reply-To: <20260618-b4-pwrkey-v4-0-4bfda105bdf3@oss.nxp.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
 Frank Li <Frank.Li@nxp.com>, Bough Chen <haibo.chen@nxp.com>, 
 Peng Fan <peng.fan@nxp.com>, Jacky Bai <ping.bai@nxp.com>, 
 Ye Li <ye.li@nxp.com>
Cc: Joy Zou <joy.zou@oss.nxp.com>, imx@lists.linux.dev, 
 linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Joy Zou <joy.zou@nxp.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: SI2PR02CA0024.apcprd02.prod.outlook.com
 (2603:1096:4:195::18) To VI1PR04MB5807.eurprd04.prod.outlook.com
 (2603:10a6:803:ec::21)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB5807:EE_|PA2PR04MB10157:EE_
X-MS-Office365-Filtering-Correlation-Id: c71d86e4-ddfb-4ec4-797c-08decd0b4e3d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|376014|19092799006|366016|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	oSxv/zwzIC5PZrdCUrFMLRIcad0knzeAvfSejBO3rkE/oc499MRVy7AUt7atvKTV0u6gzASsSmBq3pNRxURiz8Yero7uJ7mptweTedzMtrCSvsuM/gNpZ+TJqIASrA+tJPfxx/sV+ucqsup/m23vK4BDlBWEDKPX5vt/H37twONs+GcCnslVgF3Sj5KmN9LzEmULQInUDcpL8gTKT9TEtGiNHKDhtxOXbcV0QrZqtpagehp4b1Xw37qkdnTQq/9h4iqp2aaSQ2n7UTb0+kCZtfvNZGC9oxo9RFfaba10zAKFt7/ExMITiX5lS/cCtyUNcDg7LL+FWDpM0j0HHE7oRpWPdKFlQ8P7iQPcEDhdTJoCLnViBdMG/AytKp+ftTsT/ENjNTvEMxYoEdIZJssUw8xwHNsaWMVHLAhbsd6zugzLqang5Wxwc/U4OxZrx+HIv3pDWKBoFC6BgfSI5VMZ/syiMM2ufuXqY+xu+WrMkbVlzI+F7xrly8Qvux0j5DcfWEugJu1VAO6liD7aeVYI3ASdGIVAIFSoqggsiChfhYAI4ievsfusViv3S+hAYemmLFUV9hycK+3D0cIYvpigmM817T8Kfp7klaullRptywAvS6xpWCmUqHg7JIVvuIbzhvvuTJV2WGplQywpCSWPja5bn3c1kbyvR/UkLoTo5u4HZQvAky3S6+7NbZcIbXnf
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5807.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(19092799006)(366016)(11063799006)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eW9PaXlRWUxzUVI1SEJqUXI3TUQ4N2dVRlkvMFFiZmlNeUVCbVQwa25zdFNa?=
 =?utf-8?B?TllwekhzdUlnL24xbFZ3QWZOYWJUNFVhamp1Z2xrMUdGSzR0VGt0bkxJb2R5?=
 =?utf-8?B?UnFSTUZFK0JHaWpYVmo3ak5zZklIWVNmUUFlRWplOUpXQSttZDloVHNFT0ll?=
 =?utf-8?B?dEF1YkdnbGFDQk96bkNpM2xvTVIyNUxHbTRQZHFqekdQbjZrblYzVVlFb2FU?=
 =?utf-8?B?OS8yTTVndS80bEUxR0F5VktOU3VrQ25vSmU2dVJnNTZySlBOUzV4aEVxZjhu?=
 =?utf-8?B?SHQ3VWhpTFFBdVJyTytaL0lQaXFsK0hkOUphN1FXMzRKSUdBVVFLOXJOa1VF?=
 =?utf-8?B?R1lOa0tLWTR3UUI0aEZXVzNFMUEyeXlSdzhYT2xhdDNZU0ZoN25GQkNlVWVR?=
 =?utf-8?B?cTdzN0J5K3N0cmtNdFdRZG5idGdkK2tBb3dEdEs0S3VLUmRYdER2UFJyUk8y?=
 =?utf-8?B?b0orb1NSd1RCMG1ESEl0NEdrRVIyMHVHY2V0OWYwNFpKR0lQcXVqR2NlL3Ez?=
 =?utf-8?B?UGxSbUNjU0JYenNJc2ovRGoxTnN1RWgzRmQ5QUszcW43OUlNc055N0lzNExS?=
 =?utf-8?B?ZmVOTGtMajk0UnNWWEpGS1VmTS9ZajZDa2loQW9TeGs2bUhIYkh6WldpekYw?=
 =?utf-8?B?NmVRVFBYaWJteDdwQU5BdkQvNVpxWHFMRnowdWRIL2x2Nk0zRk9TZWtrWmhV?=
 =?utf-8?B?R1lEMUZmZ0RheXVPZTR2ZndvMTE5UzBhVENXTmNUc3VUUEpIa2tVTjdJQlR1?=
 =?utf-8?B?ZDVzL3ZwVVREdjRMV05VdUo3d3hHQzZJVHZrNmtiTEswSklNcW5FakllS1RF?=
 =?utf-8?B?S3BMM2w1YmR2NVdhQXQ3YnNNVW1rdVJPWlB6OXg1UWM2cHJWZUhCRTB1Um1v?=
 =?utf-8?B?cjlGK1JyZ3hpLzRIL1BrQ1B4UE9EU1FNaHNxaituZnV1dFo1VWx3d3dwdXM4?=
 =?utf-8?B?QXE5SFE5L0VqamQwTnFSeXcxMWxVU0o3S3pGdXJ3SHRKVUp2eW8zbjBoQTRa?=
 =?utf-8?B?ZVB2eDkvYUJSMnUyZ1EwaUNROTk0S0g0ZTRWa3I2SFI1NFBndDcwcmw5SlFV?=
 =?utf-8?B?Slh1Zms3SDdFQTIvUGVjZGN5eURqbWlXbkxzUUdicHdHMnB5Vk9uOU5ad3g2?=
 =?utf-8?B?RzAwdnZLQ2h5ZUhES0VSZkhEck05ZklRakJUWHY1WGRVQnlGcnFKbldMc0VE?=
 =?utf-8?B?R3Z5QXZpTDg2RTFadnRnNmNtUFVqNE5STXdpbS9qcUlFV2pZSm54N282aWJu?=
 =?utf-8?B?M0NaazdhcG93eEZZVmZjczAxTkdJbFJuS2xLZkJDMWUxYzR3Vm83YlBoeEls?=
 =?utf-8?B?Z0F4Vmc1OWNpNUQ0NWNHalhUeWIycnhIWXk4K2hKbzdDeDZJd1Z3dkRLZDBX?=
 =?utf-8?B?dGpJQ2NTV2t1YmN4dGhjbVJKL3lLMFV5UzZlMnFzbmtEQ1A5M1NIM2xwMkZl?=
 =?utf-8?B?ZFFzR1NCL3lHd3V2ZWJPa3lxU25uM2d5cXpiT2hpREdmaC82U0FFMnlNaVpR?=
 =?utf-8?B?aDhWUjkyZzVmOHRPRnljZmU3cVZsMVZYMlVZUHJEbmpzT3FJRkIzdHlqVnl2?=
 =?utf-8?B?REhCWk9hMDBVNEdEZ1BtOWZ6MUlKV1RMc1hJeUFlNVdwd2xkV2pGZTJqeHln?=
 =?utf-8?B?MWpSNWM0RGJQYkU4ZklPL0YvVUxOckExcU1iRHBBOEdGeXBEM1VxelUrMWsx?=
 =?utf-8?B?SFVOL25NSld3SmpMZlpqdVIzcXNFSy9JdFU0akk0azhqNWN1K1V6bTBOOVhw?=
 =?utf-8?B?ZS9kVWFrTGhnNFBBcnBTMm5FTWZVeHhmb1BXQzN0WGZybmdzdU80Z2lIRko3?=
 =?utf-8?B?NzFwcEJQQS96NVE1TWFnQ3pJRHFOSGI4bExlVVRuWXF3cmx1M1krRiszNmtk?=
 =?utf-8?B?VnJsOXZ2TSt1VGVrbkZGREJETG1Fd0lUTjRzYjlTb1JwblBpREIvZ0pMVG1B?=
 =?utf-8?B?R1ZreDFHSXdOZVdkN2hLekVLbkxxU25SV21rRDVCTVppMlVYZUlseXhYNWY4?=
 =?utf-8?B?TkExWHdBRkZmY0IyWnh6R3AvNzBDTTZnMm0yemhDcXNvbTNXeGJ1N0d6eVZa?=
 =?utf-8?B?OUE3cDNodDljKzB3dkd6OG10OStORjVNUy9MdThGSUdJeFFibWQrSG5CWmNu?=
 =?utf-8?B?K0NuRU0rYW5aVG9mMC9wRDhUTEV1RDlMYUtRVkRrU1ZtV2QzU1JwWDZpcmds?=
 =?utf-8?B?Sm9XdGllUndrT2djRUJDN0xuN2RacEFOU0dBT3NmQUVQOTI0ejFXcmNkRUh2?=
 =?utf-8?B?d2VlSEFwUXA2aElQOXBka0VuS1M3MHZrNVlvUWovMHhLUVdCazd4MHEzSGxq?=
 =?utf-8?B?MmJhdGZ6L3VBSDlJRlNhckozVEFtcWNKSEJBanhiWGM5S2RwRWNtbnpKTGNv?=
 =?utf-8?Q?mEPrrqk7m4ygeDuLiAg1cAdW6A8ZJ2EKbmkAD?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c71d86e4-ddfb-4ec4-797c-08decd0b4e3d
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5807.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2026 07:29:17.7502
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BOO25fzB0qYkheK8n9jRJFXbAnmw8eUhyFngj3UoA14HXLYMGfDCY9CCWHAmFaN2prpjOZIHERoQYppNItRIvTEx5utUEmqwWxVkgaVxRwiOokniYg7FZ2tLHYAJjypn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR04MB10157

From: Joy Zou <joy.zou@nxp.com>

Use local struct device pointer to avoid reference the platform_device
pointer every time.

No functional change.

Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Joy Zou <joy.zou@nxp.com>
---
Changes for v4:
1. Add Reviewed-by tag.

Changes for v2:
1. Use dev instead of &pdev->dev for devm_input_allocate_device(),
   which was missed in patch v1 per AI review comments.
2. Modify commit message.
---
 drivers/input/keyboard/snvs_pwrkey.c | 41 ++++++++++++++++++------------------
 1 file changed, 21 insertions(+), 20 deletions(-)

diff --git a/drivers/input/keyboard/snvs_pwrkey.c b/drivers/input/keyboard/snvs_pwrkey.c
index d58bbbe9fd58..cbe44a38d2b3 100644
--- a/drivers/input/keyboard/snvs_pwrkey.c
+++ b/drivers/input/keyboard/snvs_pwrkey.c
@@ -112,6 +112,7 @@ static void imx_snvs_pwrkey_act(void *pdata)
 
 static int imx_snvs_pwrkey_probe(struct platform_device *pdev)
 {
+	struct device *dev = &pdev->dev;
 	struct pwrkey_drv_data *pdata;
 	struct input_dev *input;
 	struct device_node *np;
@@ -122,26 +123,26 @@ static int imx_snvs_pwrkey_probe(struct platform_device *pdev)
 	u32 vid;
 
 	/* Get SNVS register Page */
-	np = pdev->dev.of_node;
+	np = dev->of_node;
 	if (!np)
-		return dev_err_probe(&pdev->dev, -ENODEV, "Device tree node not found\n");
+		return dev_err_probe(dev, -ENODEV, "Device tree node not found\n");
 
-	pdata = devm_kzalloc(&pdev->dev, sizeof(*pdata), GFP_KERNEL);
+	pdata = devm_kzalloc(dev, sizeof(*pdata), GFP_KERNEL);
 	if (!pdata)
 		return -ENOMEM;
 
 	pdata->snvs = syscon_regmap_lookup_by_phandle(np, "regmap");
 	if (IS_ERR(pdata->snvs))
-		return dev_err_probe(&pdev->dev, PTR_ERR(pdata->snvs), "Can't get snvs syscon\n");
+		return dev_err_probe(dev, PTR_ERR(pdata->snvs), "Can't get snvs syscon\n");
 
 	if (of_property_read_u32(np, "linux,keycode", &pdata->keycode)) {
 		pdata->keycode = KEY_POWER;
-		dev_warn(&pdev->dev, "KEY_POWER without setting in dts\n");
+		dev_warn(dev, "KEY_POWER without setting in dts\n");
 	}
 
-	clk = devm_clk_get_optional_enabled(&pdev->dev, NULL);
+	clk = devm_clk_get_optional_enabled(dev, NULL);
 	if (IS_ERR(clk))
-		return dev_err_probe(&pdev->dev, PTR_ERR(clk),
+		return dev_err_probe(dev, PTR_ERR(clk),
 				     "Failed to get snvs clock (%pe)\n", clk);
 
 	pdata->wakeup = of_property_read_bool(np, "wakeup-source");
@@ -162,7 +163,7 @@ static int imx_snvs_pwrkey_probe(struct platform_device *pdev)
 			bpt = (val / 5) - 1;
 			break;
 		default:
-			return dev_err_probe(&pdev->dev, -EINVAL,
+			return dev_err_probe(dev, -EINVAL,
 					     "power-off-time-sec %d out of range\n", val);
 		}
 
@@ -180,9 +181,9 @@ static int imx_snvs_pwrkey_probe(struct platform_device *pdev)
 
 	timer_setup(&pdata->check_timer, imx_imx_snvs_check_for_events, 0);
 
-	input = devm_input_allocate_device(&pdev->dev);
+	input = devm_input_allocate_device(dev);
 	if (!input)
-		return dev_err_probe(&pdev->dev, -ENOMEM, "failed to allocate the input device\n");
+		return dev_err_probe(dev, -ENOMEM, "failed to allocate the input device\n");
 
 	input->name = pdev->name;
 	input->phys = "snvs-pwrkey/input0";
@@ -191,27 +192,27 @@ static int imx_snvs_pwrkey_probe(struct platform_device *pdev)
 	input_set_capability(input, EV_KEY, pdata->keycode);
 
 	/* input customer action to cancel release timer */
-	error = devm_add_action(&pdev->dev, imx_snvs_pwrkey_act, pdata);
+	error = devm_add_action(dev, imx_snvs_pwrkey_act, pdata);
 	if (error)
-		return dev_err_probe(&pdev->dev, error, "failed to register remove action\n");
+		return dev_err_probe(dev, error, "failed to register remove action\n");
 
 	pdata->input = input;
 	platform_set_drvdata(pdev, pdata);
 
-	error = devm_request_irq(&pdev->dev, pdata->irq,
-			       imx_snvs_pwrkey_interrupt,
-			       0, pdev->name, pdev);
+	error = devm_request_irq(dev, pdata->irq,
+				 imx_snvs_pwrkey_interrupt,
+				 0, pdev->name, pdev);
 	if (error)
-		return dev_err_probe(&pdev->dev, error, "interrupt not available.\n");
+		return dev_err_probe(dev, error, "interrupt not available.\n");
 
 	error = input_register_device(input);
 	if (error < 0)
-		return dev_err_probe(&pdev->dev, error, "failed to register input device\n");
+		return dev_err_probe(dev, error, "failed to register input device\n");
 
-	device_init_wakeup(&pdev->dev, pdata->wakeup);
-	error = dev_pm_set_wake_irq(&pdev->dev, pdata->irq);
+	device_init_wakeup(dev, pdata->wakeup);
+	error = dev_pm_set_wake_irq(dev, pdata->irq);
 	if (error)
-		dev_err(&pdev->dev, "irq wake enable failed.\n");
+		dev_err(dev, "irq wake enable failed.\n");
 
 	return 0;
 }

-- 
2.34.1

