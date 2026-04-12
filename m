Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azolkn19010089.outbound.protection.outlook.com [52.103.10.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 363E21E8332
	for <linux-input@vger.kernel.org>; Sun, 12 Apr 2026 00:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.10.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775953445; cv=fail; b=gxeO80rv9MG9SMvXoZxcgJTgdjpBaqNKSxshmfBGqYk72DwHKGDaFGo9ytUUPuhx5VuKmS/gGsSUZ9pjTOMiQstpLpnHPNiYObW0d9PNMxfT/W+H4lwAfa+ZSOIpCsJ63R+DfEtKjpuclXn7M2ghYiRCLEElNB+ycUxrSmByBlY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775953445; c=relaxed/simple;
	bh=1ivRguUxwPu5BlHrDiHHvTdj4Y1CpPMAhLErGTmaG2U=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=WIASeSzQqqIZqwT3sIDEyMEr4GS7oGM6PEPvm5gopn92b1rNyQf/6aermrlkFHpnR4XSb4NVFha4/kd0JPv3F7nf6ycCTBvr5hHXbTo4r0eQ2wB+hW0O0D0I6TB8jf6RqvpbZmjynkeluu5lL7h2UhBnjfjwo1vmMjyHJQ1gHLU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=R8ZD6Sf+; arc=fail smtp.client-ip=52.103.10.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="R8ZD6Sf+"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iFOFR5x8AZFuzTvqcg5tSZXK4Gx1cbgYR3b0AXgVq2Assow2bb4DpR58ygvCrS5wiUtVRtMKcNk0NMW0uu2I1cSpPPnjc7QiDXeEFqoZrWzNmFnlfpIwGQYCOaEbdRJEjUFRUOzZGEPLeedjTD/9VE+TmYzTRCDbcc+YoYqVYCM5bmpOG/rzy5fEYIYKIdVrPq7XdzeCY17QcDOKvIkz3AehcldCacFpbRzdbpwK8gy076b5XeJuSJDUd1M2h/yoLmLK7VGX/5Pr+wILS3OEeSqdJnS7xJDl0EviVouejRzjsZXoLXsyL40gsu1H4erps8dKZLl0fbP6BJyFeRoR/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9Nr/kHTATYtunbBoI/fv/mXlLPnXh1zNvfesrdGF2Y8=;
 b=O+v46WS7vx2byRGztcb/DPQZo0anlBc280t7PPvDROIVKVoU10GCl4m/1QGQsJ4Fci4jjT8vWHPWyTe9EMgt+E2RtZ9cf2WkVOccwl/PKl436AL5JSgy9mIkMKNAV2CHkJEyKpv4aW8Jg5nGOszva51Rj6/yHXxTdy1sROG8Exj+QdYIwQT0qOdSLCS3SqVK6wn6LkHnLs+Rs+UhC1NGRcSXpSvddcWnVRdV33lKKpRIuA31FJDBOupuTUERIoSfPngUjrmht1WqfLvdJ1CJzJmbnWA3DKrYU/BzwIg6GMEb0RBS5UxdxZMyg2puysn/Bh3N9gqqRhVfOLb+sZ6ZwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9Nr/kHTATYtunbBoI/fv/mXlLPnXh1zNvfesrdGF2Y8=;
 b=R8ZD6Sf+BTe1YggeZeQ4C7VoUb24jXSD4npqlNn+Vi9JQmqb2rOiT3DyZpbC4o/nACHd/PHJIHHMq8yndoBTxyLQswe+UFsy+OPG53KcPWsQD/wIQdcvVgxFyy8O+1sstB2J9v2mfXJqUDyvill2aEpliKHYP37Q28CEUhOeIdHchrY82BzvzWNutq0zyPq//1Gb22rIek1QAk2LI/FvLd8g2+L3e6VNY60jryE3f6pL15iqBiCb1M/Jl1jt9vOocLR+Bk3z2AJX7ubIP04vBwgSI2hsVYCKmE4mS66f9v7ji+GgNH3FJfC/ZTV88bUBl5HxkRExrsAws4k1apam3Q==
Received: from MW5PR84MB1356.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:303:1c2::7)
 by PH0PR84MB1718.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:510:172::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.47; Sun, 12 Apr
 2026 00:24:02 +0000
Received: from MW5PR84MB1356.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::f2b:f6ca:1788:266f]) by MW5PR84MB1356.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::f2b:f6ca:1788:266f%6]) with mapi id 15.20.9769.046; Sun, 12 Apr 2026
 00:24:02 +0000
From: Anj D <aduvnjak@hotmail.com>
To: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>
CC: "benjamin.tissoires@redhat.com" <benjamin.tissoires@redhat.com>,
	"lee@kernel.org" <lee@kernel.org>, "jikos@kernel.org" <jikos@kernel.org>
Subject: HID: core: regression in 6.19.12 - short report handling floods dmesg
 for working devices
Thread-Topic: HID: core: regression in 6.19.12 - short report handling floods
 dmesg for working devices
Thread-Index: AQHcyhEzmrb6rDzahk+KyETU/h76tw==
Date: Sun, 12 Apr 2026 00:24:02 +0000
Message-ID:
 <MW5PR84MB135613E7947113897DD9FDA4C7272@MW5PR84MB1356.NAMPRD84.PROD.OUTLOOK.COM>
Accept-Language: en-AU, en-US
Content-Language: en-AU
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW5PR84MB1356:EE_|PH0PR84MB1718:EE_
x-ms-office365-filtering-correlation-id: 47f1005f-d116-4681-4471-08de9829cc3a
x-microsoft-antispam:
 BCL:0;ARA:14566002|15030799006|461199028|15080799012|20031999003|39105399006|37011999003|13031999003|55001999003|31061999003|8060799015|19110799012|8062599012|41001999006|3412199025|440099028|26121999003|26104999006|102099032|3430499032|40105399003;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?znBstE9WIHC3/5ZlkvcWgF6ORtIyjIgWIJpT0mbWuE4cXDcsrXOtUK4/k0?=
 =?iso-8859-1?Q?7knyUHN6SuB4iEIEXmVaxENkwLF0YdD2eXFfFvaN2KtSDx+kFe4XTYRT2f?=
 =?iso-8859-1?Q?GfOb0gVVahxKKBIfcm2I5717VimopAuyiagFD7Z/f/c315MzShw1Y0uC20?=
 =?iso-8859-1?Q?HWZujbq5hKjYC/o9+kcKDJJI5fmW+hTZ5GacUE3VAolyuvy/ww7IPNPOlG?=
 =?iso-8859-1?Q?EJesGymZAncGvVgPRTSW6+3SesvTfRKeNzh6i5zmT03ter8Gu+Puak3oux?=
 =?iso-8859-1?Q?HJNbVl2hu1RLp931C4AIZpIGWQ+t4sb6MN2PNlH2M9i7BO7OhMcxboWpGf?=
 =?iso-8859-1?Q?RqKWUnSEp3thKnweKXn9qla+12TLw3NqspuDNlMnmHDroO5XrClMHej57V?=
 =?iso-8859-1?Q?WAowjG7JYl7mqlMDRUiowANWD9LMCIJqr2j96PkGBeC5eOZFhVBQxXlgHV?=
 =?iso-8859-1?Q?wq+XBO0dxD/+SV+0/Y3LbSYBLEyBDXNJyb1S1qo9PY2W2wm1fGCHeft4+r?=
 =?iso-8859-1?Q?cdiq6QjnJ8oy1vc4PvNLziV9W2+OaZAkNT/bPy5z/OvsExkjuR9AKP8C3c?=
 =?iso-8859-1?Q?Jf1hyl6Xyj/gsW6RKkYRfgciQN4cDW+7CtmYIqza5pKTQUDRLc2ZgU9Jul?=
 =?iso-8859-1?Q?u3u70wE36fkijDgCJmGI/Qruv4SIxbNbPgp0A/OUR9UupRT5IxpqIev0Vg?=
 =?iso-8859-1?Q?NkMHdGRmDeSJlvRXPr0fOJiwKHNdT21V7g3HNVYGwicS+CeaD8nFN+eIM2?=
 =?iso-8859-1?Q?cFb2a2YyI8cXSI/adayNgrHFspHYHQpBJd55SsPGK/aF+LUFR481cKrCD/?=
 =?iso-8859-1?Q?r+3jHQxMhKINV/nAn1BnmVpUxA33MskkUOaJdKY+eBg4hqhhuM6gE+gqDA?=
 =?iso-8859-1?Q?qEZ5THOL/VJ5Co2SBYjbg3E6f1F4YwpS9N7cBZsddXilt0tGEbWFEVSgM3?=
 =?iso-8859-1?Q?OZA0tMIbPa5rSUjVAbS9uUqls3oIWNRP02Y7X4qlSWWIH3f84SWB1lbu7v?=
 =?iso-8859-1?Q?dK65N3JYQWl0iXhvTs+tUO1jYA58e4aSGaMzFH39ER2Q4ozmVJ7B/U5ERV?=
 =?iso-8859-1?Q?NVpfoR2K/fggUnP3sg7OEI2KMyn8TXoNc1wy6RfANKE2f36nqtK+wnZ5up?=
 =?iso-8859-1?Q?FI3ZnO1E1wAuOYKTrr+A1Jt3iy0bnz0D9m19eGRpnqIQxgUmaRNeGbxtWk?=
 =?iso-8859-1?Q?qPfN7mXiO7aJs7HaNWyqYyyc7GjirmRH6ks=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?vCzLdn/uufbvTHXxs5Fq2KchyXmHNDsOGeW/YOvdrMQftb/1VKZg+PyVcL?=
 =?iso-8859-1?Q?58GbHgJKcnUW3JeHobF0M46KOWdW04FE9QjTzWg7oShWD10kjIxB+/kGM8?=
 =?iso-8859-1?Q?icU5WWPEg4alDR5VM5aywmuseVZ3bSJ2hg4lY8yktVIvt4xQII/Q052DXG?=
 =?iso-8859-1?Q?hn9ejpFgPqBm4KzaYF7vH3oJgq7xIj/I3uSZaOKPVTRFJps/NSu5ALtlSn?=
 =?iso-8859-1?Q?n0+6nhIAp8vpRAFZj5b2HJu/rIn1/Ju9uCUv71AIXJIPLzj4P5MQnwQMZM?=
 =?iso-8859-1?Q?tN9R8TuhlXIGoNH8I3+WghY14f50fHC/m7bArQfObY8JZML0IvWvnoB7Se?=
 =?iso-8859-1?Q?DR68MGYFjl2ruQX9QhsYZ9KNpaiBbgAZd73QsnVxBr1VBK7y3apon5r9/B?=
 =?iso-8859-1?Q?xRaQF9ugUvQOHeO7XPfSva+d5h3QMxKzffcsmtipr4YxIgJj1TMRI+LXKj?=
 =?iso-8859-1?Q?c0+48H9m4YUXlr9BaBTt2eds6yM3MTg5i425+z99bi+eNi+EnBxHJYL7aI?=
 =?iso-8859-1?Q?uwExmlZ+PTPmOnkEtTVrLOLO5LmU45qDJipwr0nJsy9zb8iVgNveiS9/O7?=
 =?iso-8859-1?Q?FcbmqMOJJi6CDO4B/lMLOP2Txg6AEw+xp8IJMWCNRLteDm2ZfterEHUzGw?=
 =?iso-8859-1?Q?VIYC6f4APZ16yzCm1ImoVqE/Cr/vb+i2O6JZxQWy04GAB1qzK+INOSeOn+?=
 =?iso-8859-1?Q?srKyY8dRE9oBFAAtmIljHghUax7z61dk3MqRa1rv7EUfq2TuZ7am8Q0dOn?=
 =?iso-8859-1?Q?h4ieHzhxc4BaS1PRnPZ+f86qfzF/ZSbWAQb3iGa3xB2mOp7u98KFM2agKc?=
 =?iso-8859-1?Q?Eh66AEy2elq4lQRmNtZ03iy1kyiqUJytiK9rDyvcNC9feFUw3LEPT0ovpW?=
 =?iso-8859-1?Q?/9DA1W2bHxbqqmTlQETp0mT//bdDsg8AmTjgiOEstc64AbGpU3i4T0ncRT?=
 =?iso-8859-1?Q?xvX9VDa3kuo1xJ90eAfUFDaZRTrDKC0fYaLNJQxrvHW7eIsHCNhBHNz0lZ?=
 =?iso-8859-1?Q?0qchcJF2RUdTZfFN4CEyultOwU6QDBUUC5E1rf+++8AhDOWfIxxrzJy+32?=
 =?iso-8859-1?Q?p6VEEAOV3rzjO15TR2hB0ZmdMBxad8remodZ9oHj21WVeAArMQjHuPL7lg?=
 =?iso-8859-1?Q?qo8QD9I/1C45X+t7vijmXvsZ3lm5efS4mDGaSt06929S35dOxT2gmKRczb?=
 =?iso-8859-1?Q?OrFiXKQkZVDzzxCZuZYZcCkttmeLkTNNChVjmrOo6jlfqa/24Gu8Zvnf9D?=
 =?iso-8859-1?Q?M/jOHA6M2bl02aWQmOAZBLdTQNluOorxL1zExiPxsASqQ+3SpB1m87QFRL?=
 =?iso-8859-1?Q?Lmz0m52fDF6RNjDl13rPLjVmN5QXsm7YxPF0FbhzTS+MJAxG6S8MwTnKGY?=
 =?iso-8859-1?Q?S/ix0OZEh5WclotQQ1JVV2DVpUe0vWITUnmEld/On/7o1ocpas/1k=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-4a72f.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW5PR84MB1356.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 47f1005f-d116-4681-4471-08de9829cc3a
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Apr 2026 00:24:02.0343
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR84MB1718

Since 6.19.12, my dmesg is flooded with the following -=A0=0A=
=0A=
hid-generic 0003:051D:0002.0007: Event data for report 22 was too short (4 =
vs 2)=0A=
=0A=
This message fires continuously at polling rate (~every 320ms), with the=0A=
rate limiter suppressing batches and then re-emitting, producing significan=
t=0A=
dmesg noise on any system with this device attached.=0A=
=0A=
The affected hardware is an APC UPS (USB VID/PID 051D:0002)=0A=
=0A=
Bisected to commit 0a3fe972a7cb1404f693d6f1711f32bc1d244b1c introduced in 6=
.19.12.=0A=
Reverting this single commit on 6.19.12 restores the previous behaviour.=0A=
=0A=
The APC UPS firmware has always sent HID report 22 with 2 bytes when=A0=0A=
the descriptor declares 4 bytes. The previous memset() silently padded=A0=
=0A=
the short data. The new early-return code logs the mismatch on every=A0=0A=
poll, flooding dmesg. The UPS functions correctly otherwise.=0A=
=0A=
Suggestion: Since we previously only reported these events when HID_DEBUG w=
as enabled. =A0=0A=
Perhaps we can continue to do the same? =A0i.e.=0A=
=0A=
--- a/drivers/hid/hid-core.c=0A=
+++ b/drivers/hid/hid-core.c=0A=
@@ -2057,7 +2057,7 @@=0A=
		rsize =3D max_buffer_size;=0A=
=0A=
	if (csize < rsize) {=0A=
-		hid_warn_ratelimited(hid, "Event data for report %d was too short (%d vs=
 %d)\n",=0A=
+		dbg_hid("Event data for report %d was too short (%d vs %d)\n",=0A=
				=A0=A0=A0=A0=A0report->id, rsize, csize);=0A=
		ret =3D -EINVAL;=0A=
		goto out;=0A=
=0A=
=0A=
Or if it we feel it is necessary to report the event, do so only once per d=
evice?=0A=
=0A=
Best regards,=0A=
Anj Duvnjak=0A=
