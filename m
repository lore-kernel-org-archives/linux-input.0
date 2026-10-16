Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F37494503F1;
	Fri, 16 Oct 2026 09:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.152.168
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792142225; cv=fail; b=Rbt6O3OaOOtegihU4NJutJAkvAJlpam5/UvSxdpx/DtfrzhyHP89yCs8fP4P/AYrYn50azIgeZRLfSIEOSfDG577rMPmZgXH+BCcWidIO3SijMAcr9b2FgMKmM40VxcFEGXCw1jp5H/YH0ijZ5W7gDdMiJqcxQ1xudV8McbzmS8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792142225; c=relaxed/simple;
	bh=8a33tK4H9PMW5kF41D4c8RI2rc9Sv1t3zajttK3dHZY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pyaUIid96muxuNAupKqncknqUtuGDuQWP28n2804mHVMu5b80NFuSyjzNM8Mzps5t4cXFtt0m0e6aQRbPln1iN5FOc3+QVxzum+IEjo4hhT0gammPxp2OBRFP8Fj+ePLRhgf2je+qJ0XqCFlwhxMVaeZlMgw+DdhzK7bp6wmU74=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=MG+Qw16c; dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b=VGrpBWk/; arc=fail smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="MG+Qw16c";
	dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b="VGrpBWk/"
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69G49Za92481999;
	Fri, 16 Oct 2026 04:16:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=PODMain02222019; bh=VYW+K06XJoRXE/vl7H
	dGdId04cLlUHYsSHjptBYS1gY=; b=MG+Qw16craxSvkHuHwyvCuouTKJkqVHo4D
	uPOgyfR02yUAR9ymdwGeYa/D0XOZ5nAyD6DPyYxFIwSJnelWEo+U4yckl90kUbem
	pAz1WQ6+ktsPfw3CCL+i1sWz2bEyE4O5kv72tLzhpGOcmr+sRwQW/Dct8cR+QDT/
	a8CRIVNRu3hEj37xK4Xq5T/BlyyW9OnNuB7PbN3QWcIZCz7eK+ILnr9nKetlIEdm
	BSL4e7unTK/Ni9CVw/VKG7gsxOe7XLcacu8msZbrRKcLs78QCuwN31VIEg0AseC6
	9ST62uC5NDDWoA4mi28MA+s4nM0XlV98mUX8kTQrbSFsFpYJ9wKA==
Received: from bl2pr02cu003.outbound.protection.outlook.com (mail-eastusazon11021141.outbound.protection.outlook.com [52.101.52.141])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 4hayq6hjpu-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 16 Oct 2026 04:16:53 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LxeaLQPEGDHu/NY2Bcqp+kEDZJxWYXMTZ+hcbT5NBE0GCV1hE1sroEPjoFl3wMhOCrzsrwhAN2qEzzF73lvb8EUryCKS8yDL2pvTinUmBaW5HvPSr8hJ6oxTe6oAMzTaLLrQYDD/jsc7HtXwglOzG35SJU5BdSKvh+GEBu2YKYpLSbWIzlRIYIWmBDJlv9O1RPYBs8lfqYpuD0a0TURI/lFLgRnUWfz1SDZvUknPfrT19fogGyoh3dHmwMm3KMqufHoJ/Hj3X2xydIQfADqFWccEghR+OUTDDdPS8AIEgY/jXch0gtm77Oyy0HIbdSTOOv+BtD+7OpS4wn6opRsX4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VYW+K06XJoRXE/vl7HdGdId04cLlUHYsSHjptBYS1gY=;
 b=Y1GfTXzZGqLG9V9BZKAvoZzfYQdvz9mvjPeA0b7Ed5URxcgnMp5wjTfNf8Rmg23NPrNMJxH/2e7lfMwk40T5uQCGr+ZK4uccZo+3dL1dc2P4TnetDYofOnU5a1uOf2eik2GmHd/i65oWpYMqAa2zTZN5cabI7uftQC9dc5l/carhcbcelv7V7X7rnnQoLihN6+TLue704MYjB+wzBshv13mOAwW57YT3/3m55REDpt7RYdQqBSmZhmS5LWT6bbK6h7RxXXGBKwU1is+AEIugIB20Db8WPEn254DL4bOI7xfImD3tg+8gptfccLOvkgQDyP+mBVBn4xnBoS39kgxaTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 84.19.233.75) smtp.rcpttodomain=cirrus.com
 smtp.mailfrom=opensource.cirrus.com; dmarc=fail (p=reject sp=reject pct=100)
 action=oreject header.from=opensource.cirrus.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VYW+K06XJoRXE/vl7HdGdId04cLlUHYsSHjptBYS1gY=;
 b=VGrpBWk/9hLsZp5I1mMqrmH/N/c2zNhj4jBn8g/gagZ9di3tZ+tgxGX55XIJU7LpUi6986Azegmbjd3EIs7O606LCUeQW7Jw8bBosc+vJWhsVGQt6ILPZYws5Ql1NbEtvv/InFArIgr/aEHkTNkczvE9DbJ9N1ByIFkA3GvJxok=
Received: from CH0PR03CA0232.namprd03.prod.outlook.com (2603:10b6:610:e7::27)
 by PH8PR19MB6738.namprd19.prod.outlook.com (2603:10b6:510:1c9::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.17; Fri, 16 Oct
 2026 09:16:49 +0000
Received: from BL2PEPF000352D1.namprd02.prod.outlook.com
 (2603:10b6:610:e7:cafe::74) by CH0PR03CA0232.outlook.office365.com
 (2603:10b6:610:e7::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.4 via Frontend Transport; Fri, 16
 Oct 2026 09:16:48 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=softfail (sender
 IP is 84.19.233.75) smtp.mailfrom=opensource.cirrus.com; dkim=none (message
 not signed) header.d=none;dmarc=fail action=oreject
 header.from=opensource.cirrus.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 opensource.cirrus.com discourages use of 84.19.233.75 as permitted sender)
Received: from edirelay1.ad.cirrus.com (84.19.233.75) by
 BL2PEPF000352D1.mail.protection.outlook.com (10.167.249.139) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.6
 via Frontend Transport; Fri, 16 Oct 2026 09:16:48 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id C5D44406540;
	Fri, 16 Oct 2026 09:16:46 +0000 (UTC)
Received: from opensource.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPSA id A5FB782024C;
	Fri, 16 Oct 2026 09:16:46 +0000 (UTC)
Date: Fri, 16 Oct 2026 10:16:45 +0100
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: Myeonghun Pak <mhun512@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, patches@opensource.cirrus.com,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ijae Kim <ae878000@gmail.com>
Subject: Re: [PATCH] Input: wm831x-on - free the mapped IRQ on removal
Message-ID: <atHrfaqvmjQirAs/@opensource.cirrus.com>
References: <20261016024300.3660850-1-mhun512@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261016024300.3660850-1-mhun512@gmail.com>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL2PEPF000352D1:EE_|PH8PR19MB6738:EE_
X-MS-Office365-Filtering-Correlation-Id: b138ddf4-d25e-4ed8-fcb2-08df2b6634df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700016|23010399003|61400799027|16102099003|22082099003|18002099003|10067099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	5x8AvaQ0GwdVJZl/iXt+OcHdi2ctQeYxxO5rmRiN2U8BIxtWr77nXUGzsRXTaW9LZy3NncA39mxcbQiVIHGJq/5JJnFDYWL/WhyomZr31jcUcmAsLSNZOmhHQJRjd3fjR8QTGxAb5B3ZpBL9GRYZOylrQixEPMWBkHLjCvs6peMyrwW2+LgQEVSSi+zr1bnFlQnkWxMDAb04oJTzJxc9zV5hEVhWNySp/medtGxf2KyMmurwBvMOrSfdW68m4mkh9AEtw+6uMW8fVJTA4alxtfWiQm8cACbdKm9gKdWNHOYRzIQw0afIOJw5vVCZyB6VrGis/xFlQC0PZqOAbod6ZaEgDZOOT5PMaq++5grYPPlyzwDGVtba3ovIBYiYEalJL/hHFvWLywvBgYBKNaLPyBgvnYVBPNWmMuLNydi30eoYVxR59KDz751cknoZXItNyV+3o3zjjTHSUfC3H5J0UX+5w/MTk7In5IF5Zlear+M/ad3j0+H6lv04TYXuv5Q+EWQnn5twkcSOIJwpjkKJa3QU38XXOikOovUQLZXvArPzQQIS0AN1lyCrEBJn6Ew6NGQAeuHT9tp8SRVktplas91NdFEBoZIgCE6kTl1YjWECdTXq3YHEWLQVY9B40riej88FYmQys+y2EME4/Hr0cwPcai8P62kEBFd/a8yQyQVzZUG4ByWyphfi3a/PmqhQjQX71E8r0hegenKuvO2tzg==
X-Forefront-Antispam-Report:
	CIP:84.19.233.75;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700016)(23010399003)(61400799027)(16102099003)(22082099003)(18002099003)(10067099003)(11063799006)(56012099006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	hlgQheBREG84Hvs5kVM2i+TscJUDclIesJVk34QE1t+GGdgCNGuvakJlig807ZALZZDP9Yu3cqzsUCVtS/ydLowvOWEV19uMTqeK2eUeP6BLO4wEGJfNDjl02WaNzGgveaZK3wV1BVTP/grXgdHx+5PzsxRmvknV5P1jNmm7Kl6jSw2q6lyglXZm8yQ+2jFXDYIVB/MtOIZyS+vU3F9L8x0aiGh2mMwLDcUkxb8Kuen1fjS9WbXqlU1+zPtTBcvJ6kwuMEZaFZiYK4Em9Ry/NRsq6bick06yaQr/H/IIlHdddsEMciIRA9eLdqOLCMHyCUVWl9gHMCUCUypjYVNcT/sZCbVs7saCoR8+EuRZBuPAGchSEwDTL+G5jZn/m07UWlIC/efKJy1E2kJ1pFX8uszbCbgaxAg5raQU0DTV5uuj+kkgwzQ9JjdUzeYYg8HY
X-Exchange-RoutingPolicyChecked:
	uP37SNVmrKW7SKKbjbbeqi936aIcz9KpN9AueLGD+qO18fBfxKtr3tMxbyZwrWiX4CRYxBdIFEGmL2BUWO0W8sCMJUAA2GEWOJbf7WPWw2Cmhsm2ai7MA2HHhDpCpN4bFs+tjXINyFuBPCA59B1ywS7W0/cjgNtqM3XZsQHZ4jYOdK1rN7IE3ckSaVAoW5flMVxy7F17wg7w1YEmsHT4bkpTaYXX9sedq0ajWEkO/Ai7aFT/xTZ/piRplBwqwrcKWIi+DiL24+qc9BOleJvAuGH4euVQ5G5tNeFxsoycD+PSwXYJ5GCE5Oz6ywd3L+VKIMEDjgYMl/lW9o1LzKQTFw==
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2026 09:16:48.1432
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b138ddf4-d25e-4ed8-fcb2-08df2b6634df
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-BL2PEPF000352D1.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR19MB6738
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE2MDAzNiBTYWx0ZWRfXwlxdzH6rRvDE
 exVI0Gul25IZhN3pIUV6JOFB/YgdR2hU+ONOBK8ZwUMQtr0wjumrFVMnvdImMFLF3Rl68h7m2Yn
 C1JcQx2Jo5omgGi6fXQpzmHYRmbsgYc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE2MDAzNiBTYWx0ZWRfXy5BVJCSFmdEg
 Y77lgIqsONrXpi0aKI+gtS494THqooIZ1V93klO5H74nfPP1mFsYgP2LYnlCYKSrflc0kFO/ZFo
 oI7A+5EyQIfA7UZ0bbqmn9bAA+RAB/M/XD24EtsBNiyBA1g8EkaCSftm7hTyJfCL4YG5fHumEo8
 7Iq+JkberEziE7L2+AfQnaK7Rqs+DD7A9turYQGArmOMCZ2eeciRCQWUHJ+WHNRnImcDBsVJXte
 3wHqks4Qwl/nQ2rkrgE6C13enEi8MyoLMsiKFeHmSfTWWJ1MFB8pKM2l7XH2fowzHFp4ccou4C9
 yYESq2ymFtFxuaz4AhJSr65kWxrluLvGwCWRJt1qUYzBQexAO0DzZ+PQdi0IkGNeFzzvrXqTZHC
 wRj2lo5tGYR3KgZE5X3QpIql7HM3yKIlVL6cS7k9BRDXf3u8G2ZtpQDsqvQ4+MH4j7Nlle8s1aP
 KvYYEddf7oQgwjMJpxg==
X-Proofpoint-GUID: kQiEkgZHBaeGJbQkXbh0yXsXGeoOU7-h
X-Proofpoint-ORIG-GUID: kQiEkgZHBaeGJbQkXbh0yXsXGeoOU7-h
X-Authority-Analysis: v=2.4 cv=UuX2pOwB c=1 sm=1 tr=0 ts=6ad1eb85 cx=c_pps
 a=ATTLtrtrxPgGSLD8O921vA==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=kj9zAlcOel0A:10 a=660iZSQnnn4A:10 a=s63m1ICgrNkA:10 a=RWc_ulEos4gA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=iX4cTi3TZMoOKdANLEfx:22 a=KfkQE9S9VqCBgivYGm0O:22
 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=w1d2syhTAAAA:8 a=-M0x4IKp0kl-76dTt8QA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Reason: safe

On Thu, Oct 15, 2026 at 10:43:00PM -0400, Myeonghun Pak wrote:
> Probe requests the Linux IRQ returned by wm831x_irq(), but remove
> passes the untransformed MFD IRQ resource to free_irq(). The two numbers
> are not guaranteed to match. If they differ, the ON handler remains
> registered and can queue polling work after the input device and driver
> data have been released.
> 
> Store the requested IRQ and free it before cancelling polling work on
> removal. Also cancel already queued work after free_irq() when input
> registration fails; free_irq() waits for the handler but does not cancel
> its work.
> 
> This issue was identified as part of our ongoing research while
> reviewing kernel code.
> 
> Fixes: cd99758ba3bd ("mfd: Convert wm831x to irq_domain")
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Co-developed-by: Ijae Kim <ae878000@gmail.com>
> Signed-off-by: Ijae Kim <ae878000@gmail.com>
> Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
> ---

Reviewed-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Thanks,
Charles
