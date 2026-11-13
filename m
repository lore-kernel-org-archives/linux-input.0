Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794578391;
	b=SqePKLaZ7tM5241wKz1Zi+r+/4iXE2oZ69nGp0qm25F0OR16CHHt6CdjtnFgiRqPf+OS
	 Q/QDRR8GYEIXU7G6Rr4HpoNsyLflIgPYYFedxsb0NVe6osWgu+/+PwqGnHfqKaXQeqUiz
	 M7UUxdzLgKtYsEBy7gH9lGzFWr2h7VO7IBWU66FagC9JrxYoAWtRjIrQvdYZlMmE2PH/R
	 pg5FhkktjFpLi+zv/669bKTqIi7M3h3jxg1ce0w77sFOTtb3i6Nv4P3Okne/VPDTO/fjm
	 XeW7QLMYrk8PiOvT4zB2HDPM8ACqaHIYsloxiTDRIMxTaOkUmBOa8vLlnLN0Vlvxd2w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794578391;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:X-Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Proofpoint-Spam-Info:
	 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=wWzAUjZknh4jZl3NcGcDKL8d9zuu/SZC4rP1w2kOxz4=;
	b=TIhZ8C/pd/6rXsnrJqD4xf/ZDaVwvcvCBTOYX8KnbBBp10t2CeFJz0FydmM79FUJ/ghS
	 y7yxDw0OihvQv4IakWxAaRDsRbxQ32NiaBqwiDFaQCgFLkBMasqRx++UwVO89B4u1sHxI
	 ffiM0feRwuVl25V4R11cLIvGTuMzcbkTlQKcMWcpcHMP2jZHEu/QITtNLn2OdXjiW4Cc9
	 lsMWaTjtXiwINnRt4sP2avskx8GWR4L/ZMRpXJ54SF0XwqTN8vG95vUCJWxshEWvStpXa
	 yBX0ideYit8ksa2l84Kn7+lhbr4O4unrdWePDX1si3xNbEoQOxslRCSonhPOy7eN1ZA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=BHGYa9dw;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=ZfT69EnD;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6059A606A893
	for <linux-input@vger.kernel.org>; Fri, 13 Nov 2026 13:59:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6059A606A893
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=BHGYa9dw;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=ZfT69EnD
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ADCJoC4516559
	for <linux-input@vger.kernel.org>; Fri, 13 Nov 2026 13:59:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	wWzAUjZknh4jZl3NcGcDKL8d9zuu/SZC4rP1w2kOxz4=; b=BHGYa9dwBFVPl3bH
	262z7vPEMx6Ep/+o9Zt/ee7SXdvIkpmkK7lS0UL3XibqX3ypzttHtwtcJL8z9YPE
	XyHL4t7/YWiiXzNU2XTmdN7ZqgT4s3PumGhG/9ksPU6sBn0cSbJLDCzIxJ7X9YP4
	B3K8MWkecn0doWzpI8EyFsotiYTeqhb6ZsyBBD1U4u8IPbWPVtps4QFEU3ZBIH8q
	MUsLx1CrsH/4D3zhYiHfI28X5PUR1k0mrMa4XgHcjeXuJR6+TvpbGhvni/g+R0s9
	Wgb3yBNkrfZjYv1bx+u7rvsr4Cju5hGf2NHvPFyaYSIQpCoqgePyuJg+z9jVLgID
	fWcpdw==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hwkfdkeeg-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-input@vger.kernel.org>; Fri, 13 Nov 2026 13:59:49 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-91eaaefe98cso426216d6.1
        for <linux-input@vger.kernel.org>; Fri, 13 Nov 2026 05:59:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794578388; x=1795183188; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wWzAUjZknh4jZl3NcGcDKL8d9zuu/SZC4rP1w2kOxz4=;
        b=ZfT69EnDWJJ1B0t0ndDA6/z5KWGkJytbdRoMaet0dfFN/ADd4YQrqBs8rWzJYbSOZG
         pjMG+1zLBiYtROrFxT+D4eyhA4Py2gvtZKwrlxumIxVVd8uyusO/U9y+IBH2OkApzd9o
         7vA4DOcaX8uNjkQIUP1fXDJD+xoUjgb4Ofp9qcKHRb7/qDHp6bfr+2gDxWhmVfZTRSE0
         jX41WsBqQQBTVULQ4arcWjOl9e1E06U10hrVwxYr7GM4VkBJCGtOZZRqvmeq5qEJkM1e
         4L0D8Os8OHe9lcXs7rXz9ULhx/U7rgRL78z5N5TrIg4Hwn/1Yg3sSSxfdg96EZnOmwF/
         wCxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794578388; x=1795183188;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wWzAUjZknh4jZl3NcGcDKL8d9zuu/SZC4rP1w2kOxz4=;
        b=MVCtED7kTlXPdTvBqHASJAfl2/kMeHM+//gEc3Spt4alrqqkUesOTx0SRzr4RsB/E8
         ggoapIxa1JPM1P3osDUVstrnjjqXvtEMcTbmKnbCmq935l8nHXPd8Cx3DE/rIx5IafHx
         Bj6s8KV/9jKHqBufIVDvFifad2j3Jgau6oYK3uVQoOr+Npt/PMYUijhBGgma//lFwvPG
         7sWbsH4ampqphVELmAM103RBXj6/s80+dTmohrVX1Moib3DCjDfP68OgVWcg+aG0/El/
         Nisky3W2BKSvGT1D13JxiQJjah9k351iuBJXeL00r7H/YiDe4mk8czya0UHbDm6Cksy0
         NQGA==
X-Gm-Message-State: APuU4Z/rt0OSPevAXjml8cNKg9LwdNBkHcmEvvkGZsCVWwyPGGmcVn+x
	9ynNgdrEJCZh7Et9Y6XOWqKQCjcWI/Cm5HP9EhLZuRSlz5HSEjHlJF91RlyH8s9tIW3iOLMu9Ob
	gt/8WrN/6JuRJO9WceoSHoeoGHEnX7gydETYgLQYVBKS37kSOj/Gb0EFg1ZjwRGqO0w==
X-Gm-Gg: AYBFou3Awrgoa12H7xHQuWxeAJU0tUHiV2achIxEKOXHSGYkVdH73uI1/4ta5HviRYG
	kboIEk7SDDTSMsUhY3otYuIqKYqlsOf6HKJKBG4a1vgA/8vueE7bb58aIqUKeX80EnMQiiXOGrv
	FKZSEof+KohHI3ZgDg90ar7I9AytRadO08JaPePpmfwgoIJiSvOobBOzQJL2DINwkn3YUIWGh1I
	BYcDSLQGiOu3UXudWEx0jwNhryzRel+Nov5eVKtg8LNXozyiMBjVnoWRw34bEuoBZz9JX5VjiS3
	WQR8Mt/QOrE81I5Sihsw6zQ4GlXEqiqpm/Pknygevq+WmmQ1Va/p4+RY/mUAKWYmB+BsJX2IL7C
	hcAiz2VU9tiCNocVeUtuR5R1EemVVX9iTUKXo0DVxjwExDeFlK3qcuuxfQoXuHhk8TOsG5fw=
X-Received: by 2002:a05:6214:3103:b0:914:521e:7da5 with SMTP id 6a1803df08f44-91f2405e286mr55051196d6.1.1794578388562;
        Fri, 13 Nov 2026 05:59:48 -0800 (PST)
X-Received: by 2002:a05:6214:3103:b0:914:521e:7da5 with SMTP id 6a1803df08f44-91f2405e286mr55050386d6.1.1794578387916;
        Fri, 13 Nov 2026 05:59:47 -0800 (PST)
Received: from [192.168.226.72] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3ae2b76b6b1sm8150891fa.6.2026.11.13.05.59.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Nov 2026 05:59:47 -0800 (PST)
Message-ID: <182a6790-90ec-4083-8da2-14be30803740@oss.qualcomm.com>
Date: Fri, 13 Nov 2026 14:59:44 +0100
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
Subject: Re: [PATCH 2/3] Input: synaptics-rmi4: Support drm_panel_follower
To: Konrad Dybcio <konradybcio@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
        Vincent Huang <vincent.huang@tw.synaptics.com>,
        Bjorn Andersson <andersson@kernel.org>
Cc: linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
References: <20260911-topic-rmi4_panel_follower-v1-0-c1b2cf1cdb62@oss.qualcomm.com>
 <20260911-topic-rmi4_panel_follower-v1-2-c1b2cf1cdb62@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260911-topic-rmi4_panel_follower-v1-2-c1b2cf1cdb62@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEzMDA1NSBTYWx0ZWRfX0BhlUbi3IH4K
 4k3OwT7T81q/tovjs16a7L1V043K0xUMYPWPR8DPwXuo2NWM0fKleMkkUijUGlWHHZMfPxHW9xm
 Zbj1I2d7WVf/ymtXBKQYYKrZ6ikRF3A=
X-Proofpoint-ORIG-GUID: KpeMXFospUVwoDX7MUbLKrifQC77YYyv
X-Authority-Analysis: v=2.4 cv=DoTDa2/+ c=1 sm=1 tr=0 ts=6af717d5 cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=hBt2bvH4Q003rsbsdR0A:9 a=QEXdDO2ut3YA:10
 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEzMDA1NSBTYWx0ZWRfX2qJjLMl1lB4O
 g5MVdk14MaKUf7l1J8CRNhP3Pm25twXZTrlkiCqkIRuXDfcOw73N4989yVrJrDpILdLZPu8dchH
 4GD9zLO8om7cvPNG6BoGJUuEyESHwqp1GRIWj0YcC5fS9vWwPHddVGdldzdeiSnFMdmVjTQCNkd
 XDX5hgQZiLf4J5CFbOV6Y1/JuOy7Kc/HujdxQcJpfUcSdIdrfWm4ZxqCUhNRQLVSS/G/zJR/fF0
 9bhuNJ/XWjHv2pkXrGuBFjfng5bVcqffzKK1PctNL69WX9Q9zrAMF4CTXApUr+C6YbVjcvXj2eN
 pQaXEX5cusOG1Z1YaUT3i8WOY3XJC4AssIw1c+O/IKMZIPRyvN/NSdPkSSNsbIsXasbgeF3JuJz
 U6ejyA51PBHmqxWC1/3ACyNFa2uP9bar+gRVY7KqjZ/Se5DXa/qo/IJEzVcIjBvZm20PgDv1QWi
 GYOgNYpHLl2G+th4uEQ==
X-Proofpoint-GUID: KpeMXFospUVwoDX7MUbLKrifQC77YYyv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-13_04,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 lowpriorityscore=0 adultscore=0 priorityscore=1501 malwarescore=0
 spamscore=0 impostorscore=0 suspectscore=0 phishscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611130055

On 9/11/26 3:18 PM, Konrad Dybcio wrote:
> From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> 
> Many RMI4 implementations are present on in-cell panels with very
> tight power sequencing requirements, normally handled by the DRM panel
> driver in Linux.
> 
> If that doesn't take place first, the integrated touchscreen IC refuses
> to work properly.
> 
> Add support for drm_panel_follower to take care of that dependency.
> 
> Assisted-by: LLM
> Signed-off-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> ---

It's been a while, since there has been no objections, can we go
forward with this patch? It would help us remove a DT bindings
violation in the qcom tree.

Konrad
