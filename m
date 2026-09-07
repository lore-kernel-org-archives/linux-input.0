Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 636FB485CD1
	for <linux-input@vger.kernel.org>; Mon,  7 Sep 2026 10:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788778694; cv=none; b=RUzCbIf7aO5W+L/DrX7zi/RCpNCcJ/NjWdnYoBlrIDo6SOEz9tNKzBbxaYN1UUb/OJa3z6prtW1Qf1BwmTm2z+0hgLvKbHbq6sw7kF1xqU+jWs1JE8g87h62v3R+2yG+I3+D3Ae+dDJlNts1lU4/gDhzoP29YcRvWqWX3El4Kvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788778694; c=relaxed/simple;
	bh=226zFTrt61gC5bUJe6htzJbBh6DTMpofqMeezkvIwVg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pTrhvbDnyumcN5NWhUcOWK7LzkvY0z+z6La9aVUQvq5nrNYoycb9gO0WJiE3MBr2PehPIUb3XvGApuTHDhUf4qJuVSUdE2kbbpNPmRUOw2RIfcZjuYAUCjuW6GZ3npCkZWthDIvef4/1ixpZqU8bHVeIU2Cfm+y6kRIPrLkWUJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=dkvbUMDt; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=GprQ5nRQ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="dkvbUMDt";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="GprQ5nRQ"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 687AnADb4064247
	for <linux-input@vger.kernel.org>; Mon, 7 Sep 2026 10:58:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=rlgWTU4l5TU2Z3+onQ2BGvvK
	P4C66DgncaDRweKJZts=; b=dkvbUMDt9tIZsDKDnW/qumgRf0QCoKn5DITnjLmh
	09vpx1rYA6zQJtZew/7pgFSenXB/eCXeg6CNmQBsaURlD0X549nMthQPOWaVkRwR
	clG0iVrhlcekgF2caXDAI3A1nipprDRsu9UaMTkpOHTVWN/r/4suIF+E/OjxFHw8
	QZCH4vfnAUlU3aW9rcVs81J/P/FLmquBkGRldolZ4VJg6IVOq2BAaobr7FG975zG
	i5zajboEKOrLseTmU42I6pXdkQHGPQcPcBPYm1V5Qa6/1aFvSN4AZc+4wJIVU2Zy
	v1dvJzE/XKGO0aWY7t7Lq5yHKO4SksM6X9N7N5gkdBkWSw==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ghs86ru9m-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-input@vger.kernel.org>; Mon, 07 Sep 2026 10:58:11 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-93909014c85so560303985a.0
        for <linux-input@vger.kernel.org>; Mon, 07 Sep 2026 03:58:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788778691; x=1789383491; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=rlgWTU4l5TU2Z3+onQ2BGvvKP4C66DgncaDRweKJZts=;
        b=GprQ5nRQWl0kq61gpkpZiRJFz7cbahjbRSnDS9VCKXD3mRKZM8Z2a0ADsRqgVuPnbl
         Bne3Shr4MLO0Hl1XtLYaUTkMPnfh/UPHq/msL4LPrZWtDNGCS+86teb6JHguyBJJBQQ7
         FNr32RTiRZImgvqTu49Q13GbH7GyKANJMzMSio84xZSArwmAfxEo2zMKtF8ttruRWqMJ
         ei738JA6YOXHuxoKRnN0MHfBZbr74MjPe+l6dAWBJM7SHNYLwx13X5w45TD1MlXD6GFM
         7wWqyYGESGOOJWoxZniv3b8n8P4nr6Hfn5pEfaknL92bMmT+u034kgBD3jQ6WxTXsabN
         nX9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788778691; x=1789383491;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rlgWTU4l5TU2Z3+onQ2BGvvKP4C66DgncaDRweKJZts=;
        b=K3ixCc33hXWnm+s/3IgqpeLWUT01OTFaBiM9BnLdT/wLStzFd2S5odY39SBUY3V22a
         mT9d8CrLsQhy7EFa7s1cKcNpmEcavM7alagz7Pi9X9CTl5GjTAwGgqsm5efYzuRhkLc6
         o5DwY0AHaD/vzyRGyrzedtVF1y7c0eJlLk1+tle2bWcXANXNJ5tbXaw9sSsh2GOoC8PJ
         XHNxkAJI/s2P3O+nOa9TsfOresXr6nPqjV92/cbUH9VvU6sqcBmPyAGi/C10qE6ulfMw
         tKJWXDctsUQo2GP3Mdxg+YAv0JYojmcB7dOVZ0Kd5y20SnX97Kcj3jo9lj5AGmmTvVKP
         QcHA==
X-Forwarded-Encrypted: i=1; AKwUvBx3JB8qO8xoY6jpzAdxYEOBNLiNs56ObiPoZNy8j7Ead8l8lrpev/o/kSKwMMprK6xPKH9PEz9VYbQaaQ==@vger.kernel.org
X-Gm-Message-State: AFuF++lyzpkZoJVzZlo0vRj5veqyNxj6Qj5hN5s4edP43TRqWQ2nqHRO
	WLtYJzEHTsB2WQsQLCRXtP8KsR5uAVTZnyte/2sgkBbVobYg82emDFJZjJE5cZP9WilqCCp0w0T
	hqIwxBd21mrzgs2qrhvwiKafoGZmfVo9HcT8vuC/WShFNQzd1jQGyYRKQY2zgBoHjJA==
X-Gm-Gg: AYBFou0MLFLY1RN4Yt8mUj1r3mnnQogJsEEbSvf5lt78U4HShHwPTrGXnOY3yfXOugA
	CzgN5Ri5Xtk+xlGJ/qrbj5otFpX3kxcWpF/MLJwBl+dzf6CgNz2jliJKm9WMPeUYRcWAK4PoFWq
	1hZ6IEGDC2IiRr1We5DmT8pGnhXF027MFNIx2Irj/Eg+fYkvsFLRErOZ++RihkZTgzOCEhDz96j
	lzpT3mmVXQVTwBAOiuPGqjcqR9lrWxhXjxRGPtpPlPcoHCBqwPND+k1kqR1mwGL9Z6w/riVJwRG
	G9DnchUfv8pCTPRytdNCQYnO6Ickv1H4HmggZX0qOR+bnPEnNEp6/87xLVr0lX2jap0bmc05Ckc
	oENBZGMG4r38ksw==
X-Received: by 2002:a05:620a:a495:b0:936:883d:89c6 with SMTP id af79cd13be357-9398043579bmr1824664285a.28.1788778690491;
        Mon, 07 Sep 2026 03:58:10 -0700 (PDT)
X-Received: by 2002:a05:620a:a495:b0:936:883d:89c6 with SMTP id af79cd13be357-9398043579bmr1824659485a.28.1788778689899;
        Mon, 07 Sep 2026 03:58:09 -0700 (PDT)
Received: from oss.qualcomm.com ([86.121.170.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49d0656e7bbsm200216825e9.10.2026.09.07.03.58.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 03:58:08 -0700 (PDT)
Date: Mon, 7 Sep 2026 13:58:06 +0300
From: Abel Vesa <abel.vesa@oss.qualcomm.com>
To: david@ixit.cz
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Henrik Rydberg <rydberg@bitmath.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Petr Hodina <petr.hodina@protonmail.com>, linux-input@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzk@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, phone-devel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Subject: Re: [PATCH v7 4/4] arm64: dts: qcom: sdm845-google: Add STM FTS
 touchscreen support
Message-ID: <bif2vhuzfskrniqvp4acoxfjvpyypr533ulwpvo3f7pwkcods3@wa47jbyowcpr>
References: <20260907-stmfts5-v7-0-4a53381cd038@ixit.cz>
 <20260907-stmfts5-v7-4-4a53381cd038@ixit.cz>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260907-stmfts5-v7-4-4a53381cd038@ixit.cz>
X-Proofpoint-GUID: 8AAB-McsbSy6lK4cjxN--tOW1ZQTWPjY
X-Proofpoint-ORIG-GUID: 8AAB-McsbSy6lK4cjxN--tOW1ZQTWPjY
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA3MDEyMCBTYWx0ZWRfX3syuJFDyu/E+
 Db9HJfR2bc9vRTcA93kwyMDFbZKApuM91zVVRaNpRmKUdplFgiC7tlN8opbUJySqM0dBGZ0vHvh
 MOLy4I7ske7n0Vm7JHr17ght3/EZypk=
X-Authority-Analysis: v=2.4 cv=LseiDHdc c=1 sm=1 tr=0 ts=6a9e98c3 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=q7XEBjOi5DRkXzmV0jSBjQ==:17
 a=kj9zAlcOel0A:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=sfOm8-O8AAAA:8 a=EUspDBNiAAAA:8 a=edXKPL0xb2b_iQIxsCMA:9 a=CjuIK1q_8ugA:10
 a=NFOGd7dJGGMPyQGDc5-O:22 a=TvTJqdcANYtsRzA46cdi:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA3MDEyMCBTYWx0ZWRfXxe8Jo3SJFYtQ
 k6eW2RkWf216kvv+hyXBIoIxcYXS83hIZx5dmZZ2HRD6p7LHYrNqqW0EWrDhSjXMrvwr9hjbzCN
 Guftf53A3HB8OhrqfmU/WoroX0XdoDJKPC9ZGKuZRRvCfUAMC6c4aJ334EbOj2P+EZ1kwrTuce6
 XwRhte/nGdO43O6pzN4elnERtNSaquYLDlz4Wfds2lbE45SgAkaos/MuZ5MJMaGMNgpWu4ETHUO
 jzxbQGlKjmEIl0CvczpPCbjrzFMM8yu2GXFCDEvlhdnZrnhqCL51zdQSRm/nRmmEV/ZtIp0zlPB
 yLRWfixuXlOHvmE0CBUo0XHwyeTOArXKg5aemTLXpXS7FM1KhI61rN8c70MVirSoe/P2FAQwDN2
 GZv7FbGdGsJMWyGi6yH5oFCVLkkk8CIqTqH2VHHJYbOIM5uilxeSKYznqdnATNZUTWUOS0Zy3rk
 m0EB7Mthlm1u9OmowBg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-07_03,2026-09-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 spamscore=0 lowpriorityscore=0 suspectscore=0
 adultscore=0 bulkscore=0 malwarescore=0 priorityscore=1501 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609070120

On 26-09-07 12:50:22, David Heidelberg via B4 Relay wrote:
> From: Petr Hodina <petr.hodina@protonmail.com>
> 
> Basic touchscreen connected to second i2c bus.
> 
> Signed-off-by: Petr Hodina <petr.hodina@protonmail.com>
> Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> Co-developed-by: David Heidelberg <david@ixit.cz>
> Signed-off-by: David Heidelberg <david@ixit.cz>

Reviewed-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
