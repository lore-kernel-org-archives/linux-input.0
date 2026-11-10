Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=67.231.157.77
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794337107;
	b=e6r2H4gKWiuvwwP0SvJ7xJvKDsXbJ28mzmRkq8ZwmFMAXsYtWSSLZDeomqtx/pJXjZY9
	 xk/ulA8l0TS+YfSQUNkR9+Pu/tFrG3oQQ8Fi6zQqE2us4cyMaCIstDJoLdlAzxXxYt/zj
	 W3cpavpQYqnnwhlkOgXK5HklJXEVwZah/udFG0jmhzvzEP42DVJjJXP/Tkl5T1MfHlaM7
	 zyLdHecL7TCuzlf8GvcmzFBUMMsyNipdyzE5akt81wr2o+HJt/3sGBHCYreT1l0Y7EtQO
	 q6vMFU8oBjW+Q3xnBx1M/6gK12rXBbbCKiV3p9rWirNlTsRc68iRWtoUEs5jA13sNmw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794337107;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Proofpoint-Spam-Info:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:X-Proofpoint-Spam-Reason;
	bh=b9yAerH+ikZFGWSwPjO2qvwJ9ahUuJgsCQeCRgJ5H1c=;
	b=khoDbrExHTFzyxYo5Nv8p+RNTyy1+27/dkx29IxI3Tlxc7xBiE3X5OyLdxfkj5yv1f98
	 ghgLRKusdnFdnIztIC55gSli2m0IlN8axDXA39r10w+Xb5pBp3b8sLbMAFwS1cIwx9vbW
	 XkWgzMEm1eI9FEcBu9Tm5UpKWmlb75SHWZR1qIY8wqBMJjHbUh6w3TOTI4JB60lePmGwG
	 Oo+UzVjWgT9DgIRcGix3UaIhO8n/Xn9jkoi6Z8mBSFrVrC2GT0k/3y+lShmTiOZJBESox
	 onetfabWBtQvBtQ9QVH5/9RoGb5Y46r2SQn4EshkOi2slNlQL1vFhwRAGLlWjMRwfRQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=plexus.com;
	spf=pass smtp.mailfrom=plexus.com;
	dkim=pass header.d=plexus.com header.i=@plexus.com header.a=rsa-sha256 header.s=pps1 header.b=hHd6Uej+;
	arc=none smtp.remote-ip=67.231.157.77
Received: from mx0b-0046e701.pphosted.com (mx0b-0046e701.pphosted.com [67.231.157.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8C24606A31C
	for <linux-input@vger.kernel.org>; Tue, 10 Nov 2026 18:58:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C8C24606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=plexus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=plexus.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=plexus.com header.i=@plexus.com header.a=rsa-sha256 header.s=pps1 header.b=hHd6Uej+
Received: from pps.filterd (m0425992.ppops.net [127.0.0.1])
	by mx0b-0046e701.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AAIq0eC3579382;
	Tue, 10 Nov 2026 12:58:09 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plexus.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pps1; bh=b9yAerH+ikZFGWSwPjO2qvwJ9ahUu
	JgsCQeCRgJ5H1c=; b=hHd6Uej+yswqAdhIWKFNeoXQXC4YC+jAATi9DO6RA2Qye
	TI8cVy1iprnWy9TRG6FnLFBymiSV9RdtvoHbg5i32zMNDz6TdkQ6SHCQY1XF0Hq/
	gkbOSFXmT1isD60knhR93ohY6or6bD6UU/TKQteftAw6LDWl2+GggEGWhUiHCg6p
	P6MwiJuSZRgJyiPDjeCOGib51Al76/hWfA4Bke8mNPE9DcFq8nB6dV2r2uLoNfFS
	riwPEkaOFyt9VuJSMes6tTERUuTCi19kXmibCDQ1cOhoiB7Djgev9jsSBGcke3Hp
	U2T8lOl6479DJK8vQ9b4evOAw7zdbiX3f1qYnomdw==
Received: from intranet-smtp.plexus.com ([64.215.193.254])
	by mx0b-0046e701.pphosted.com (PPS) with ESMTPS id 4htpdmmt2t-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 10 Nov 2026 12:58:09 -0600 (CST)
Received: from localhost (unknown [10.255.48.203])
	by intranet-smtp.plexus.com (Postfix) with ESMTP id E1BE03C841;
	Tue, 10 Nov 2026 12:58:08 -0600 (CST)
Date: Tue, 10 Nov 2026 12:56:03 -0600
From: Danny Kaehn <danny.kaehn@plexus.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Jiri Kosina <jkosina@suse.com>,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        Benjamin Tissoires <bentiss@kernel.org>, linux-input@vger.kernel.org
Subject: Re: Firmware Support for USB-HID Devices and CP2112
Message-ID: <20261110185603.GA102891@LNDCL34533.neenah.na.plexus.com>
References: <20260520-cp2112-dt-v14-0-b1b4b6734b6f@plexus.com>
 <autpMnQT8t0Ecu-m@ashevche-desk.local>
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <autpMnQT8t0Ecu-m@ashevche-desk.local>
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEwMDA3NSBTYWx0ZWRfX2cUd9o0rL4qt
 jMAArdGnWdvb01McI1h2q5VX8X7CJHExK5+R+iNrCu7AcUe14ZsKgF/xR3MXFftaU0zjkXs2FZ9
 HRFmWF17l3xZS09/Aihm49hpNfHRlI5Ybwkl9Nw8hCZuNwmdc8Hj
X-Proofpoint-GUID: kvZfZ5EBQBMIvZvRA6GrNBICZOYkNfi8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEwMDA3NSBTYWx0ZWRfX+/lOAou2Qgpy
 dIG6X/pZl2RzM/Wg86tDeg2663FygcOjVbjxK64QCHvcl/vt9dvYbZ7ubcLo4IG/2rvsbcc2Uwe
 TXkHLI76fTbThvskbK/ZLBGtLCl03sz3Ue7YjSwWVhN30AQCEjDe1vXIN4gTHv31aXLFU1WMKS4
 zQASETdtBcZukAFkQawPmtWPQSRyHiWzk6v1pdhxc+E1H7xxST0RC/vGDZ/5uqYKqEdefMLU+Yv
 SwX0I8oh7gaN39wvFAmfTuHMo11fs9/K/SwXtdRHcxh/ARyDS8sewL6kPY64K0dThOneFIrjghq
 sQM4iOsCG1FqeYHeST9pDWGJcpY2szO74Qxm1PE37kywHbuaGg/2AnsikI8K1296Aqo7ZZhTdU2
 80G+nwOuFYiIWkq4f3y8Q+M8BP4pdlW2OMJc4Pwn5CT13Ij2hcBW6dXA1m1RK15Fl7aCxGZoQJe
 Z2G+BBj7Nc/GXHAn2jA==
X-Proofpoint-ORIG-GUID: kvZfZ5EBQBMIvZvRA6GrNBICZOYkNfi8
X-Authority-Analysis: v=2.4 cv=DvvDa2/+ c=1 sm=1 tr=0 ts=6af36941 cx=c_pps
 a=356DXeqjepxy6lyVU6o3hA==:117 a=356DXeqjepxy6lyVU6o3hA==:17
 a=kj9zAlcOel0A:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=SL0Da4cj2IsybHzvybfz:22 a=6wD_j1z14G4eGgT9AmLd:22 a=VwQbUJbxAAAA:8
 a=9FNMe90RfxhSya4oBPgA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Reason: orgsafe

On Wed, Nov 04, 2026 at 07:19:46PM +0200, Andy Shevchenko wrote:
> In lieu of this discussion [1] I just realised that CP2112 misses the
> documentation piece under Documentation/firmware-guide/acpi/ on how
> it's supposed to be enumerated. Danny, can you add a such, please?
> 
> [1]: 20261003095924.1370238-1-thierry.reding@kernel.org
>

Hi Andy,

Apologies about the delay here -- getting an environment set up to send
kernel email always takes some time :)

I will target getting something sent out for this by the end of the
week.

This can wait for the review of course, but since it seems like
this is a relatively unblazed trail (ACPI "binding" documents for
specific drivers), do you have opinions on whether a directory tree
should be started for driver documents like this? (i.e. an i2c
subdirectory?), or would you prefer it just be added to the top-level
directory? It seems like there also isn't yet a naming convention for
these -- presumably the "silabs,cp2112.rst" name would be too
"DeviceTree-ish"... maybe "i2c-silabs-cp2112.rst" if kept at the
top-level...

Thanks,

Danny Kaehn
