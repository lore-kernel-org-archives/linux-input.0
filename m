Received: from mx0b-0046e701.pphosted.com (mx0b-0046e701.pphosted.com [67.231.157.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A83E6328614;
	Wed, 28 Jan 2026 20:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.157.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769630980; cv=none; b=Zo59MPhFJb+4+gogoFiqxyzDDRmrFMuNMLqafe1P3w00++7HiSVge7Qv/0xXRGRptBwMtEqHWfzqKwYPqTb8xYBLZs8rcFY0jEu0hkkBOk0m8fwzoQB1o0hb6puKu15E9l37oa2OKaP4rqPFIC+f1yPLwvwWR6PK+Jzk8jvUa5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769630980; c=relaxed/simple;
	bh=Oeeg4cjce/fxCJNh2IVHR8NEWcBWxrm3D4hfbEhsWTo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VlpYyX7A4iRyIxCt+zis/aW3o+/nUWljwDH3ruby6NuIspAYAQ1Te7LbC+Xj8vEDCD3ITPfieTnJxFGZIOjA1tlR4BPGl49M/vUN5zz5Ihy0fDYGCSw+x06w49eK6d/lfOq/ltzs/KNIsv4Uy1R26mWcTKl48KZLGTRdtpiE1hc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=plexus.com; spf=pass smtp.mailfrom=plexus.com; dkim=pass (2048-bit key) header.d=plexus.com header.i=@plexus.com header.b=lfFj13QE; arc=none smtp.client-ip=67.231.157.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=plexus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=plexus.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=plexus.com header.i=@plexus.com header.b="lfFj13QE"
Received: from pps.filterd (m0425993.ppops.net [127.0.0.1])
	by mx0b-0046e701.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60SG9rDS3469621;
	Wed, 28 Jan 2026 14:09:19 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plexus.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pps1; bh=fmLMp+sEH0p8Dn7Ha2MV6To9ci4B6
	Z6QGC+jJWGXARk=; b=lfFj13QE7oK77xXuK/tci0YbRahXU8roy9XS5V+Tlsci8
	Z6ARMqLlAHBa5/yzE8egAOFFpmY8O7+aMR5zY1IjQniWhi6Q317deHQZjwwYfIZY
	k7a6eSjnage1ho5WXVJb1D/EecVGn1LfBeTtGHVq3hMA/4GXpPxV5mewx8ylS6TV
	ZEYM748S8ahF2451ljf8rO2igBSIG40asNuHelLI0NVMB7xgo1TwrNOau3tllvn/
	9nGFfr74iy92vFlsyuF38/kPYvU6+U5Q4+kOmOAJwAmJxnijVpatHlPWtUEDnfjE
	8OwrnDceJfIQqWD/Q+hVGMgZ6TQtOyvUsX5twazdg==
Received: from intranet-smtp.plexus.com ([64.215.193.254])
	by mx0b-0046e701.pphosted.com (PPS) with ESMTPS id 4by97v9qn9-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 28 Jan 2026 14:09:19 -0600 (CST)
Received: from localhost (unknown [10.255.48.203])
	by intranet-smtp.plexus.com (Postfix) with ESMTP id 9818F580C1;
	Wed, 28 Jan 2026 14:09:18 -0600 (CST)
Date: Wed, 28 Jan 2026 14:05:25 -0600
From: Danny Kaehn <danny.kaehn@plexus.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Benjamin Tissoires <bentiss@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andi Shyti <andi.shyti@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
        Jiri Kosina <jikos@kernel.org>, devicetree@vger.kernel.org,
        linux-input@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Ethan Twardy <ethan.twardy@plexus.com>, linux-i2c@vger.kernel.org,
        linux-kernel@vger.kernel.org, Leo Huang <leohu@nvidia.com>,
        Arun D Patil <arundp@nvidia.com>, Willie Thai <wthai@nvidia.com>,
        Ting-Kai Chen <tingkaic@nvidia.com>
Subject: Re: [PATCH v13 1/3] dt-bindings: i2c: Add CP2112 HID USB to SMBus
 Bridge
Message-ID: <20260128200525.GA818373@LNDCL34533.neenah.na.plexus.com>
References: <20260127-cp2112-dt-v13-0-6448ddd4bf22@plexus.com>
 <20260127-cp2112-dt-v13-1-6448ddd4bf22@plexus.com>
 <20260127160217.GA3776731@LNDCL34533.neenah.na.plexus.com>
 <20260128-magnificent-faithful-otter-c4f900@quoll>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260128-magnificent-faithful-otter-c4f900@quoll>
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=NMjYOk6g c=1 sm=1 tr=0 ts=697a6cef cx=c_pps
 a=356DXeqjepxy6lyVU6o3hA==:117 a=356DXeqjepxy6lyVU6o3hA==:17
 a=kj9zAlcOel0A:10 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Y_joWELsAAAA:8 a=DhTynmGxdE76aj_yemYA:9 a=CjuIK1q_8ugA:10
 a=g_BQsM8wYJVSTWLOHH1t:22
X-Proofpoint-ORIG-GUID: NYeVex2Bi985EAWxbu_8AqS2ga0Q03-t
X-Proofpoint-GUID: j19qSGvH8IEpzanveuemV69Q4wFBJ3CO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI4MDE2NiBTYWx0ZWRfX7h71CsGn81Uo
 O1H0fgFDJeATCkEUfKD8nosI++J8NbeW6HB2RT7F9NUYNqNFN6PEh7g3eo7TEJblStlh4VF9uLE
 8+akhfJn1Jf6hfAq65dqoFyijy0Zn9atAOW2ui8EdbJMEbcaZroJgxeiR4uJMJ007XnmiGw3GP2
 72ex+XJP4Zvvukyaz5I7nyA+GBzn4cpxbXKNX/eH4mOefzNtH43b3eEdBKdLsba37LXE5dKIaG4
 Uhd6Jvx4I4XsfrWrYcTirhCywaLQPA3jWKi3NzW8A8QANtiCY/dBbFi/LXUPLvGm2uONYVGywvC
 1eArPHEdHuf0gfc8JDMvqkMiXIp+EI0WZHY6jpLlCWxEyjyzkuwp/3Ru+RerokJf+OxE6fbcAYi
 ydRuxMAEytpwsRQWnwtAij1KiR5F0s95KH831uNGNmaronMOQNwV9TeF1irf99jI1EJQmPuG8aA
 YFHdWVgSi4yQrF3Njbg==
X-Proofpoint-Spam-Reason: orgsafe

On Wed, Jan 28, 2026 at 11:35:25AM +0100, Krzysztof Kozlowski wrote:
> On Tue, Jan 27, 2026 at 10:02:17AM -0600, Danny Kaehn wrote:
> > On Tue, Jan 27, 2026 at 08:47:48AM -0600, Danny Kaehn wrote:
> > > This is a USB HID device which includes an I2C controller and 8 GPIO pins.
> > > 
> > > The binding allows describing the chip's gpio and i2c controller in DT,
> > > with the i2c controller being bound to a subnode named "i2c". This is
> > > intended to be used in configurations where the CP2112 is permanently
> > > connected in hardware.
> > > 
> > > Signed-off-by: Danny Kaehn <danny.kaehn@plexus.com>
> > > ---
> > 
> > Hi Folks (Intended for Rob or Krzysztof),
> > 
> > Wasn't sure the best way to go about this, but trying to see the best
> > way to get a message in front of you regarding an ask from Andy S.
> > 
> > In [1], Rob H initially directed that the gpio chip share a node with
> > the CP2112 itself, rather than having a subnode named 'gpio'.
> > 
> > Initially, I did the same thing for both DT and ACPI, but Andy S.
> > directed that ACPI should not have the node be shared in that way.
> > 
> > With the last revision of this patch, Andy S. asked that I try to get a
> > rationalle from Rob (or other DT expert presumably) on why the gpio node
> > should be combined with the parent, rather than being a named subnode
> > [2].
> 
> Because it is explicitly asked in writing bindings. Please read it.
> 
> Because we do not want Linux driver model affecting design of bindings
> and DTS, by subnodes present only to instantiate Linux drivers. I do not
> care about driver model in this review and I do not see any reason it
> should make DTS less obvious or readable.
> 
> That's actually rule communicated many times, also documented in writing
> bindings and in recent talks.
> 

Hi Krzysztof,

Thanks for all of the replies. It's never my intent to waste
maintainers' time, so apologies if due-diligence was missed here on my
part.

When initially writing this binding, I did search around for any kernel
doc or binding that might provide guidance on how the nodes could be    
split, but failed to find anything particularly relevent, aside from
general principles which can be applied to come to the same conclusion
you have about why the gpio and i2c nodes are necessarily different
because of i2c representing a true bus. This is likely a failing on my
part, but I'm not sure exactly where I'd go to find rules like this
which, as you say, have been communicated many times, aside from
querying the mailing lists.

I've started to go through some recent talks to see context there, and
came across "How to Get Your DT Schema Bindings Accepted in Less Than
10 Iterations"... clearly I've failed on that here :)

Thanks,

Danny Kaehn
