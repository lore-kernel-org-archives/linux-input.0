Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793261194;
	b=0kzlkKISMA5MDlLukLuecqPDB4drGe6lOZAu1cEBKJ6AR9+SCjfwdveEENtNV3SQc0zJ
	 fSDPfUjMqqyV5TWeEQ2m72bmy9l0/QpRMV9qallZul2/Y6JdiuZeoMZWBvP+KlnXkCoB5
	 SgrPAQFdBXgjdt+Gg88v/NXBUv/Qm7cRDFvV0DvvrknN4OMdN9l2mSX3wB0AwResJ5sCm
	 lfxKweVGNpddP6/vlg9XdUxfyHKkW/ZP0zqd9QXmASQU98of8A4iZzkpMnhOUpkb8PRYW
	 DN0gbzwA09h1WTbmcB+wbjJumimSFQCD3fcuQhcnjt6IQzRcFuhl/nP8sD7Sopy5bHw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793261194;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:X-Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=m8DFKSCsdHugXNIGpAF5J7g+hIg6cjluBUQHPY3ZgJA=;
	b=OePb01atODQQR6wHJM7Y6+jN+pNje7JzzS/HYZTUXP8qtPuIiJQBi9ON7fPOUR8VGYXY
	 9pvHlvifqi66abceWzPe121PTYN3agGdKKasGvTkVU1tzR462/1GgxVpgeoRFRofXrByM
	 rpsXJzzTIc+yG5UtHkcni30UDFsnZLfFiwfFoz/WGA5PnSzLziKNn38QiSJOcrXoPkyZX
	 1Is9Nu1oyZ+S0OIJvZint7jG0mzdZQqoWBajto/bwFHRnmCEV6pJR6mM41MBlzQo7HE3Z
	 E8o/QCqhwxX/63fZxFKUQaLYakKXhqe6jrC/CzcCOYqLmt4ouwDns1H8adKco/vqiTQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=oHi105vQ;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=QhDuiqLS;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEBEC606A326
	for <linux-input@vger.kernel.org>; Thu, 29 Oct 2026 08:06:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EEBEC606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=oHi105vQ;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=QhDuiqLS
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69T5Gvdt2974015
	for <linux-input@vger.kernel.org>; Thu, 29 Oct 2026 08:06:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	m8DFKSCsdHugXNIGpAF5J7g+hIg6cjluBUQHPY3ZgJA=; b=oHi105vQq5+kupfu
	nkq7DiBxKhWo3JDmC2j8eL7/8U+tz4p8Zw9W+sxL0IuzjHJ/0jZaAfZnKFTQ+B/c
	mZFBVpuxaKh8LVZaKjauwNrJyHs1sZG/VactDeU+xFAytxJOAOc19F5Ey17V4psq
	NEdcnixVx3y+XrZOhZnb3WhEO++31f/W+7h8rty2tzbQFPFWIv2cQUbOf6XiPPia
	4fJjCIsHFx1lfPOqqcnaFEycKMMkr4cp3S8ZWuSXvvCg+Mm18UAqA6WAXcuPawUO
	F/CIry2q5OWq12oAS5gHui+W3WMTONQIIQ86q0krZ0dFRtcb13sFE2YBSvUmqR5D
	xF6dow==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hknkpaubt-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-input@vger.kernel.org>; Thu, 29 Oct 2026 08:06:32 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-93f1f1f2ecfso42230085a.3
        for <linux-input@vger.kernel.org>; Thu, 29 Oct 2026 01:06:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793261192; x=1793865992; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=m8DFKSCsdHugXNIGpAF5J7g+hIg6cjluBUQHPY3ZgJA=;
        b=QhDuiqLSfXhXHNRwQhFoxjcmAPzJqb0vMmDNNFHdxCLXdJ4kR1mJi9roZo5ii1rJgh
         3rKAiCFZh8TVM/bID49J4pOLZCBjq/LvqxkThAS9/3el75Scc4TFtj1NdvKWoC0uJ1yv
         mkblcpoVwSs44fDG/6oBTGCnM0PnJ/N7AO52MowL0n6jeFQ1dD6LmuvXTZwMgM+SKVmq
         phvEmRHa0CqVKQIddING31lOy74Nr4jUckYNj0jhUqfRraF9ehCRAD8SRvKTvjr3KSa7
         h6WhrF06eq4JiAljJMC2pL4gj+AyOyBc0rcQ+uB2r1RGXYncsI1BYloOC8mNzqXA6Asf
         Aj+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793261192; x=1793865992;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=m8DFKSCsdHugXNIGpAF5J7g+hIg6cjluBUQHPY3ZgJA=;
        b=kOofsKZjWdtYRT+exzrJ8S0XlvaqLK60u3E8EgB8sG8GCBLwVd26HHFbpSCDxZRM/m
         J3eXHi/at7VOQq+0Ip/+gR9lzCuXECRwfYOn/491GHm5xqQTqPRPkc+qcecUPxx4Eg/k
         N+E7UcViqU2blxRr0zIxLGmo2sfQp8Pi9m8BLcmIDRH9hhvQ5TD6isuXlWruGXhk3rPP
         qPxkaQLJFLZco6xodAlYMWZwxjWFb0/KKuWH59af+QCnfa0ejoVWyp/iMUvgk00h/RZ4
         zGxwwKG/bRo0m0n2kJN00yU6bBT0Lrbn600kOl7i5RiFSpBjisUu8+OgKtmeGyDBvJdI
         P/hw==
X-Gm-Message-State: AFq9FYJWupg36ucGluCx/3axQFdnyWtYm5b3pbMZ8Czfqus4BdwNIozT
	XrmOY7TVy+mydjSc/FfhEMFfvo7TwCCoNzoYgHrbXZOPa4tkWgdxYB5wPdCM8zrzN4iZu8zsLD+
	zcRwzYbGsnlyACL6WMqY68azCHv9pJW+1vWkIrI5X5KEdvGSOBQdEliflStsOvMPVqA==
X-Gm-Gg: AYBFou29Sb5uiflgEsEZsG44MYhGHR4znnMGyku5hCx1rd3niueuFZ4TgRtF+NaZg18
	yuIU2LQWyRdt0LA2Tb7zYtLSsQDSbWhvRUYnA+0O8+/MNK9WB4Xws/7tihT+hedliiTw0anA4ko
	h+gB+kWVoO4CV0JhUenCTI43fxXZE5u22QgT5ylViMlKjDU9KpfS4UcRW0krs7cWFsu9vbu2IrT
	5Z1hiqH2EVnqkS9RpI3zdP2KMogeBUjotur7sF6ld9Hn5AF/njeJetHK9Uwf9bahmZlkjDuS+Kv
	ChiJKbGal2oo51WzaIq9Wku6KfuuHo39EC5PAJxqI5tJ/T71dnjXP/XIWc73Mf7nucfPdOEgbpQ
	vffn71E6tmPsiw1nWgHd2+uTdx+PZ3l1uYgppPUliPukjqSzEUJqaHsnVJ/I0fHMiNUFx3E0=
X-Received: by 2002:a05:620a:3bc9:b0:93a:ec4:e5f2 with SMTP id af79cd13be357-94408d42cd1mr784406585a.6.1793261192143;
        Thu, 29 Oct 2026 01:06:32 -0700 (PDT)
X-Received: by 2002:a05:620a:3bc9:b0:93a:ec4:e5f2 with SMTP id af79cd13be357-94408d42cd1mr784402285a.6.1793261191683;
        Thu, 29 Oct 2026 01:06:31 -0700 (PDT)
Received: from [192.168.226.64] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b49644e029sm2428460a12.35.2026.10.29.01.06.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Oct 2026 01:06:30 -0700 (PDT)
Message-ID: <ca9f3883-247f-4cdd-a30d-847b0c3f5433@oss.qualcomm.com>
Date: Thu, 29 Oct 2026 09:06:27 +0100
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] arm64: dts: qcom: sm7325-motorola-dubai: Add
 vibrator support
To: Gergo Koteles <soyer@irl.hu>, Dmitry Torokhov
 <dmitry.torokhov@gmail.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Griffin Kroah-Hartman <griffin.kroah@fairphone.com>
Cc: linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht
References: <cover.1793218514.git.soyer@irl.hu>
 <89f7e6e9988c8744be37093777b0bc065a0e2ab8.1793218514.git.soyer@irl.hu>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <89f7e6e9988c8744be37093777b0bc065a0e2ab8.1793218514.git.soyer@irl.hu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=Ju9kP84C c=1 sm=1 tr=0 ts=6ae2fe88 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=6KvQjkKwYJz4M-1xzI4A:9 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-ORIG-GUID: A3RRlxOGGn7N5otTcemxwz7gKvE1dXdg
X-Proofpoint-GUID: A3RRlxOGGn7N5otTcemxwz7gKvE1dXdg
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI5MDAzMSBTYWx0ZWRfXxk2QQI+szp/4
 NbXHLCGcJfmMdptv1R5GOQSSze/4jBMQR42PVS0tv/aQGf0yHwxa+5OGLHO4dl9alO0af2t8FW8
 NUn5KSp6ixgCBUtuxquFVzWR1qWAUGY=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI5MDAzMSBTYWx0ZWRfX9Mp1S/O3ryo0
 NiiDOyGK5pYV8VzdHCh92sCEHgjvXGyZNitBKNyMuUHujTTwcgOwKZwhLfbAwmn/PVTPK12+qUh
 bI/soDPh+3Z4gRK3nGGnP4f/YT2ohLtObrmUDUZwmEfPeW6uAHnaUbPQTJNeZOqdL85cVvxGFBW
 cELvd4yHiiGIPMN1g7wEgZ6221iML1zpfeNp/DyGGx+NOUrlx1KMHtk7nGubHbOhn+PRbOYzXxp
 jXrveIyXoUwCYZuMVHNleW4QWmapVFuaWgdARfePnREFOFzgE73DKhe48sIbPEM2pv+MkIDOY6d
 6JTYRTZUEVsghPo0hPP4lmf/kmxfpZerLzSo9cJQtiorU1xdpEVYT/DZCTWEZO5vM2VNaV5F6By
 i3vJXwHuMVrZ2t1aZ35NBXsusOwY2gj/jZJKE2Cl+P0cIAwCF88aXYButST6OIDx7E+E/eucmgq
 anX30B0XdgYpEaCRCoA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-29_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 adultscore=0 bulkscore=0 clxscore=1015
 suspectscore=0 spamscore=0 lowpriorityscore=0 priorityscore=1501
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610290031

On 10/28/26 9:37 PM, Gergo Koteles wrote:
> Add the required node for haptic playback (Awinic AW86224).
> 
> Signed-off-by: Gergo Koteles <soyer@irl.hu>
> ---
> Changes in v2:
>  - rebased on mainline (Krzysztof)
>  - order by address (Konrad)
> 
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
