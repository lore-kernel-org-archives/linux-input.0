Received: from endrift.com (endrift.com [173.255.198.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F4E92D248B
	for <linux-input@vger.kernel.org>; Tue,  3 Feb 2026 01:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.255.198.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770083486; cv=none; b=Ql0/7SIzWnUnw3OesFZ1pCq80Pj7eFA+j1h07h2kW4JggOB9oxJk7S7Zri4i8UbcACvsinl6YvOI9gXFTrbI5Ze4zz07wiaX3ccmYasLfg1LhGzMQFXF9UblGjZSxeqQctW7jBODZ8tQ96306XBOG33syIabvKumDvLAVOlZsC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770083486; c=relaxed/simple;
	bh=ash+WlJeYDgDXqivX/EG78rWOmO+mrKX06DjbHGP7DU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lhd/rOBhVZP9c4lHWgUMs3vpnZ3aoItEZKWV2MCL844/D5XsDZxR4r3Nua2DbY5UFeMHwieRgVIEKtMYR8UCNoC7ozFG6+6xCix6cLM3a+3BA+7dj6MfEs7C//mRXrB4CJgxEnx5jqQLmwaGSuv/AsD0FxfAn9fOQEIICoWNRFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endrift.com; spf=pass smtp.mailfrom=endrift.com; dkim=pass (2048-bit key) header.d=endrift.com header.i=@endrift.com header.b=nlFMZKnR; arc=none smtp.client-ip=173.255.198.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endrift.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=endrift.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=endrift.com header.i=@endrift.com header.b="nlFMZKnR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=endrift.com; s=2020;
	t=1770082938; bh=ash+WlJeYDgDXqivX/EG78rWOmO+mrKX06DjbHGP7DU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=nlFMZKnRTvXwK4zKZ9piKC3MYwc42yyENPKoHrYSYf/jDMlv89AwUr3RzIaEItNqM
	 Ar0c9cQGZ86yx4BPo6PO535OnVUyMzeliFEUjMH+vAkOBmOMALPd+R64G+Nqi62xkL
	 JXn2XI99YH1blm7WvzhpMqwKvQmbV5RWNwvcMRINVMLmBUVakjSVDP38j7QkjVn+yS
	 W/yFT3JP4fB7O0yVr7QGKGIT9cpABTw9tb+EvuoiM9tHkSbZqgwCeMqQCw6xSBIpby
	 s7jij8nY0YjmmURYfcm2tqlnDVvLdJLKukDdn/XEu+9kI7QR+qGmeRjWTi6PD4oh2b
	 R9ShOI/XE88Aw==
Received: from [192.168.0.22] (71-212-14-89.tukw.qwest.net [71.212.14.89])
	by endrift.com (Postfix) with ESMTPSA id 7C86EA00C;
	Mon, 02 Feb 2026 17:42:17 -0800 (PST)
Message-ID: <2fb48bd0-55ce-4467-9310-ef914e362a55@endrift.com>
Date: Mon, 2 Feb 2026 17:42:16 -0800
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Poke?] Re: [PATCH v2 0/1] HID: switch2: Add preliminary Switch 2
 controller driver
To: Jiri Kosina <jikos@kernel.org>, lyude@redhat.com
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 Benjamin Tissoires <bentiss@kernel.org>, linux-input@vger.kernel.org,
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
 Bastien Nocera <hadess@hadess.net>
References: <20260109034034.565630-1-vi@endrift.com>
 <e66735b6e1b0ac4db3dfd2aaddadcc9ff052beb0.camel@redhat.com>
 <721a51815d1cc21aa22e255ce31598035b687592.camel@redhat.com>
 <or594565-p59s-784r-494s-82o6qrn9p496@xreary.bet>
Content-Language: en-US
From: Vicki Pfau <vi@endrift.com>
In-Reply-To: <or594565-p59s-784r-494s-82o6qrn9p496@xreary.bet>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Jiri,

On 2/2/26 3:41 AM, Jiri Kosina wrote:
> On Fri, 30 Jan 2026, lyude@redhat.com wrote:
> 
>> Bentiss/Jiri, any chance this patch is on your radar?
> 
> I've reviewed the driver already, and I was sure I sent out an e-mail 
> asking for a minor nit -- better naming of the driver (we usuall name 
> drivers by vendors, not specific devices. But I can't find any traces of 
> such e-mail, so I probably hallucinated it, sorry.
> 
> Vicki, is there any reason not to follow the standard naming, and either 
> fold the whole thing into hid-nintendo, or built it separately under e.g. 
> hid-nintendo-switch2.c (which might or not might be then linked into 
> hid-nintendo proper)?

I was not aware of such a convention. There were plenty of drivers that seem to defy this, like hid-wiimote, so I figured I'd just name it something shorter. I didn't want to fold it directly into hid-nintendo since there's no real opportunity for shared code between the two of them, so it'd just mean (effectively) dead code getting loaded along with the rest of the module if you're only using a Switch 1 controller. That said, hid-playstation doesn't seem to care about this, so I can fold it into hid-nintendo if that's not a concern.

I also have a v3 that I was working on last week that flattens out the larger TODO that I had left over. It still needs testing, but otherwise it's done. I can rename the driver to hid-nintendo-switch2 or fold it into hid-nintendo for that one, whichever you'd prefer.
> 
> Thanks,
> 

Thanks,
Vicki
