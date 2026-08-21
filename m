Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59E7C39FCE
	for <linux-input@vger.kernel.org>; Fri, 21 Aug 2026 12:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787314594; cv=none; b=IFSoWAWSZaf2TGI8mZDoKmjPFruG40V4WQzjaB3blvCo6HCHI+jeOIqcGT0S1vviaysX/+lyQDwIHc+8iQLJSvteWpATlVr2Csir7shqVOEz9Oe74UzKYZeDvbqiiZyXPCqUyZMqPM/M4dbzeTzcSGuMXW2p0069qn/amP+SSUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787314594; c=relaxed/simple;
	bh=es4m+wmD6O0W+VN7wgQ8sffnaTdgYhBLh3UIN2laXIg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bwaDosQ9WYm3p4bNT2B6tH7jZL5NLRTCpSrzUc2alc/boqlj33f//ukU3qEruJbWRAcVyNTGLxrDP/zb+wFFHV1yJ10XvdaEsK6RcR1lZzyiFNuqsG066b0YpRCirKonLupI5wA2X7fnenWaLz1l0fhFs7o9/J3IQ66qv8l6Qoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=pEY/YKRW; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=H/tTn8+B; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="pEY/YKRW";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="H/tTn8+B"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67LBq2mE2225849
	for <linux-input@vger.kernel.org>; Fri, 21 Aug 2026 12:16:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=/GOHaKR3RVBKb7RfCMkw1x2U
	2ZbnpAPQz3ErgjJAqYc=; b=pEY/YKRWaYXsc8/X+VYkCLE2o7iblD0/zIvHooZJ
	/HNEwZGAPe0zXvDBZmWlrWjfwcnXRyHDrV0mJNkI6bs7TgzJjbDrOiXzU7VTPdUJ
	VjHjvfRQT0wsTPiZrePTrQvOaYQO4uEawhoMH3iNw3dMfy/fsC7BQiuP1EJqYUmk
	1btyqompS70zkRWORkgHFgKfXqMFs7LTRzISdeAiuWH88eIpWWM7Mf4lxt/f1jyz
	U9bW94BZYA7UIbF0pPNxresqRd+31KeJen7tLjQNMWShcsWP2z+Aw5z6hVO8WUiJ
	d1gR8Odme+TFdeKS05lxRa06elbdxTu1m6+qbpKbXPRQ4A==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g6gdn9grs-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-input@vger.kernel.org>; Fri, 21 Aug 2026 12:16:27 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-5276aa86d00so9699321cf.2
        for <linux-input@vger.kernel.org>; Fri, 21 Aug 2026 05:16:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787314587; x=1787919387; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=/GOHaKR3RVBKb7RfCMkw1x2U2ZbnpAPQz3ErgjJAqYc=;
        b=H/tTn8+BDj72UkeKv1EZdzGGsAOaYi0A//xHZCn3ZKW1iCSKdYndca0/XwJL7w9eId
         cFwnN+bTRWYDNQRgg6dMgAh9XPrsGu+FwuylsBXO5uAmDX8Gow4xfrv2M4GwPKv8xvij
         gYTTE0ZMI9OL4J2rR7om28VI7DrNeRi0ycKPeCfcrcwvua0kBQzJBlgabDVmmjqUM9Ez
         r8ejO910ooKGplaj4J2/34YyIGM4PuCku9xmBQaS4ub++a7ijONBMJVKRe5ZvaFag9UC
         xzN5c9I5SaKqnPrJ0x5w8mQ0QcDJ/p2cz1eZUTvINl5OsREJk2CnmOUiPeFCSu7ZOe0c
         Eycg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787314587; x=1787919387;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/GOHaKR3RVBKb7RfCMkw1x2U2ZbnpAPQz3ErgjJAqYc=;
        b=R8WSLbzmHFCkxF8UerooinWDCf9R1HCV3dSN6osikxZ46BK/J0jrrd/jRsg+tygpmc
         IBNqaqPchcrnJhw83ufmNQK4dRfRo1B37v0FfZpndbLNcMEa0WTvY7QcdoOuA4ls35ni
         9142ao7qzLaSpO7Ttd5s8QZMfa10VH4yHQAy7v74PaMmHrNQ7mqFzewaYgg/AtmM+sg1
         pi9hPcL4WBCV4mUTOA8VL7t8a9IjAe24w4wN2wCnRqDZmgttRgZgjHFDa7ZK0to2Sbvw
         yVQZdSJMGfgwNOzjXtPaS8stvuJpsax3844v2R16fDkyNvs/dsvLgzTkPz7vdebQVCkY
         5j7Q==
X-Forwarded-Encrypted: i=1; AHgh+RroRPor/HK/4w33oqDEDhRMHDdtA/herFKxQCW/WeZ+ouLo4oWd8cAFgQj3u2EQTicjW9bSJQZWdi6T5g==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1OZg8c6aATQuw8/FStQn6dIO5frTRq8m94RLfu3jVK64gDnsG
	fwJvvCRel4uYO2qGtyqXBfVA6TL6Cnv7WHgsDEg22qUK+ulYLiW3FN9MbQCMU519UGLaXt6+xwh
	sf7s00mTBOnNhTtM7R912CBEJj5/nIOxJMgapISZ3P5zbAsgYdKNxvPmg8HLmJBl/sw==
X-Gm-Gg: AR+sD11eXu+6mNFlXTQDZ+MRrYh4neVAcHVqHEPB6xKegnsPmBTuK0jbyG9f3rlRX6Q
	cNoHw1I/iyqezAj4eWW6Yyr97JBoy/Pq2NeG0Hj5frTHQ6C/0FqO150qZgbh/FeKJEJZflnnhI3
	7CGgm+YBwdfcJIxzWJeaNlPwLKxOOWVMavGroJx+TNfpAuDEirgeKWJEUeNQMq5AXzLFhzdv580
	VIS2xPrDDcAoflSLD8nS4u85dv604YKDl1Aturxelvv5bKm7Yawz8bTfYuVK6Ha9lAyO0GVV/iJ
	CG7SBI+408bS7onqflqXSZ1/E8Yn0fEz0L21SaoP/PfqKyMOOAyan90KDRCEdEC/sLmRe0DDr4q
	zG2ayNqkmNqQypGY=
X-Received: by 2002:a05:622a:4d08:b0:51c:92a0:b2ca with SMTP id d75a77b69052e-52df5a5ede3mr53201311cf.34.1787314586756;
        Fri, 21 Aug 2026 05:16:26 -0700 (PDT)
X-Received: by 2002:a05:622a:4d08:b0:51c:92a0:b2ca with SMTP id d75a77b69052e-52df5a5ede3mr53200581cf.34.1787314586141;
        Fri, 21 Aug 2026 05:16:26 -0700 (PDT)
Received: from oss.qualcomm.com ([188.27.161.240])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2458b094c4sm471695566b.22.2026.08.21.05.16.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2026 05:16:25 -0700 (PDT)
Date: Fri, 21 Aug 2026 15:16:22 +0300
From: Abel Vesa <abel.vesa@oss.qualcomm.com>
To: Luca Weiss <luca.weiss@fairphone.com>
Cc: Job Noorman <job@noorman.info>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Frank Li <Frank.Li@nxp.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH 3/3] arm64: dts: qcom: sm7225-fairphone-fp4: Enable
 touchscreen
Message-ID: <3p7avlj7fo3f7dcuamznmgzbfxiixnsrvq4qfma4f3p6jitikx@47ho7nom5uf5>
References: <20260821-fp4-hx83112a-v1-0-474941bd8860@fairphone.com>
 <20260821-fp4-hx83112a-v1-3-474941bd8860@fairphone.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260821-fp4-hx83112a-v1-3-474941bd8860@fairphone.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIxMDA5MyBTYWx0ZWRfX21RWeKTf9kdX
 y/Gv0piuYhfqaUrGwu0cDS4ZlZogY1SHVdUGuog0bllzk0RZ4gcaSB904N1kYpD2c7JVBXlizDg
 o2bbFQntHD9ss+TMtLiL+fMTuFEDWSiYRGjFDE0la7DRrQoGU6HlaulEBx0PK4LKf+qOWGd1h8G
 OsotCfpVqzSSTcCEE/h1jcOptb7Wu7OBf98xx4ECpSXzZHAcq42iOywgKrUqQcXU6M96+FBi1rI
 Z5iDhjr+JFITFKO+yTD85YUw0Bzg8J5veDcVcQaIfzu4unAZUMz0Bf3bP1Csh0jXBAZvfFbgUw2
 XXGforFrXK3B8tesUOnmMGARtS6Q3pp2pDSgM2f0k6cyahve7Bf5YFYqikkud2puPzzFUjYBoy2
 53wd2vRRw0opIo0wOGPexTaCWdcC/dU+CnM+Z9P6ALFRDNefoXONZa0x18YMXqhGx2nyLXbt6D4
 QYfD7+7nb5TadJlUekw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIxMDA5MyBTYWx0ZWRfX5fXQ+49//qEU
 2k8IQc0kMmsJwUK3+6l+If9HAhp5Ora/KMYDlJVT/ZmP0f/0xsTzxlyz84Ehrc4xI4TFhRWZ3ds
 OzBF9xmBck4nlWvaWwnmnG0/aGShdSA=
X-Proofpoint-ORIG-GUID: 9dmw8E0WM_WzTn630TkJitCgd9jURR59
X-Authority-Analysis: v=2.4 cv=BJyDalQG c=1 sm=1 tr=0 ts=6a88419b cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=wUpz7uCjLrEXi01cjX+DLw==:17
 a=kj9zAlcOel0A:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=6H0WHjuAAAAA:8 a=EUspDBNiAAAA:8 a=e_63XvbMukAsnnsCD6UA:9 a=CjuIK1q_8ugA:10
 a=AYr37p2UDEkA:10 a=kacYvNCVWA4VmyqE58fU:22 a=Soq9LBFxuPC4vsCAQt-j:22
X-Proofpoint-GUID: 9dmw8E0WM_WzTn630TkJitCgd9jURR59
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-21_04,2026-08-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 bulkscore=0 clxscore=1015 impostorscore=0
 adultscore=0 phishscore=0 priorityscore=1501 suspectscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608210093

On 26-08-21 09:12:20, Luca Weiss wrote:
> Add a node and pinctrl for the Himax HX83112A touchscreen found on this
> phone.
> 
> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>

Reviewed-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
