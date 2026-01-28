Received: from mx0b-0046e701.pphosted.com (mx0b-0046e701.pphosted.com [67.231.157.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48B3B255F2C;
	Wed, 28 Jan 2026 20:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.157.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769631527; cv=none; b=lHollAHcshOGv9UR5a3ANESeht9C3InKU6NKfXeGXw/AlSw1iCei3cR8DNXKznI41eQcQQJcvPE0eMSXyZaeq/frJd0UFRZ+QlAFb/qfE1WX58z9pri0vigcmOBmdWG6IwPwbzgU8Ux4z6MANktAWqtTPbkMLl194KbIzjEPDZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769631527; c=relaxed/simple;
	bh=e3xlZ7F8eFxBO5opt3iZWsv8TCaKKx8JGDSzfk/6Ih8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uxUV2bd2uPv+fi5nKYe6MuKO8r+A+7EH0QjOIfiIYxLLyql+sOo5WzrX0bPJqBSnpRmg5P6V0NhTFMt0jKlibUTR/pU5wNf3BKghHIEFoGsMWNiNbVhTe9Eq5Vd9FwBJzY2ec4tFIVg9Ibg7OmTaRutQRLTkIl60zfWlAyH7FjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=plexus.com; spf=pass smtp.mailfrom=plexus.com; dkim=pass (2048-bit key) header.d=plexus.com header.i=@plexus.com header.b=SPxR4jjx; arc=none smtp.client-ip=67.231.157.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=plexus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=plexus.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=plexus.com header.i=@plexus.com header.b="SPxR4jjx"
Received: from pps.filterd (m0425993.ppops.net [127.0.0.1])
	by mx0b-0046e701.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60SGMjh33469473;
	Wed, 28 Jan 2026 14:18:39 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plexus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps1; bh=vQR8u
	+ScdCWfDIiSL89yQgcRO1eBsBoxisPrgSbNTkY=; b=SPxR4jjxYQstLo33HqEUw
	+gO/17En0oAed5iBcRNiPigBNDR3ZsxyVMjnfXBwf7DdbfHOQctQhMAZKDLFx/Ux
	iWeodTEbKdmSazFVUK2Dw+K3DsI7BkK7afDwy43Gy28OQdExz4lIwRZjFehoEBa+
	tKxRgEKNjH0IrZCksj29MS02CV0BC0vvePn7ozq08X0cyuxWxWE08yxyV3I6aAhC
	ElnoG3ONq2DPZuiRDRsfWG6xmKjG+HbjZO+apTmS8UYMhBofEx5H1iEDHaBKbaBh
	UlkfXgtfXDg6kkrUVcpovIQBAArNvoRt6oqm1Cmjwd+7/wnBxl6bbf+1WOz6NIS3
	w==
Received: from intranet-smtp.plexus.com ([64.215.193.254])
	by mx0b-0046e701.pphosted.com (PPS) with ESMTPS id 4by97v9r1n-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 28 Jan 2026 14:18:38 -0600 (CST)
Received: from localhost (unknown [10.255.48.203])
	by intranet-smtp.plexus.com (Postfix) with ESMTP id 2974C580C1;
	Wed, 28 Jan 2026 14:18:38 -0600 (CST)
Date: Wed, 28 Jan 2026 14:14:45 -0600
From: Danny Kaehn <danny.kaehn@plexus.com>
To: Conor Dooley <conor@kernel.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Benjamin Tissoires <bentiss@kernel.org>,
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
Message-ID: <20260128201445.GB818373@LNDCL34533.neenah.na.plexus.com>
References: <20260127-cp2112-dt-v13-0-6448ddd4bf22@plexus.com>
 <20260127-cp2112-dt-v13-1-6448ddd4bf22@plexus.com>
 <20260127160217.GA3776731@LNDCL34533.neenah.na.plexus.com>
 <20260128-magnificent-faithful-otter-c4f900@quoll>
 <aXoF4zi4SZrXaku5@smile.fi.intel.com>
 <20260128-pelican-silenced-cd6a5bf69672@spud>
 <a579100b-6c38-4fd1-bab3-b1e7663ab412@kernel.org>
 <20260128-embezzle-deacon-74815f461fe9@spud>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260128-embezzle-deacon-74815f461fe9@spud>
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=NMjYOk6g c=1 sm=1 tr=0 ts=697a6f1f cx=c_pps
 a=356DXeqjepxy6lyVU6o3hA==:117 a=356DXeqjepxy6lyVU6o3hA==:17
 a=8nJEP1OIZ-IA:10 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Y_joWELsAAAA:8 a=3F-BqlMz6Yqr-KcdCRsA:9 a=3ZKOabzyN94A:10 a=wPNLvfGTeEIA:10
 a=g_BQsM8wYJVSTWLOHH1t:22
X-Proofpoint-ORIG-GUID: _WYnJMCEM9D92lCZ6A26ZMokJ0kNy0_B
X-Proofpoint-GUID: 28nLPFXhV-U8nwTBh52dZL7HHpHpi5vt
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI4MDE2NyBTYWx0ZWRfX733XHBhytiQK
 Zgpa5f5bCW3sCKp3OllemZ8Hx2P87QRe4wbaCPXcR+gVa7EZVvvfo+pOALMAQc7/9fL5KvX9Euf
 dlHqEfvEgn/AGwKXKH43jh0m7czQmcUwWXtJifoF4wJNvSSCzNGspe36ICysLwA0joUhOwUhnda
 RyH3Fv+9AtiMIPT6tPIAWBqtn7rGHbzZ1Tf2V98sA9ltmr0k76X/6DNhw/kHrApumpJrQr+/5d4
 Tx8cimNBdxJxO8VZytSUJ3Jbd/GkUQREnzFtV3QD4cQmASU/tne1OJs9ak/kmCSqkdCLyn1Naid
 oXsc75eWtvdXzHCVmJH5UNsONFRHvXHw8w96Rrlfehgf2qnKCdeCMLSXymYxqcznKOqoIRxLg4P
 HpDhcl+TorsxDqdIe25u5QaI/v6uTbpYKqp8Kc6ZSIWDGr+QGzsNAjlbSrRankuEgHM0FRmuHzz
 nY2X9HdbKrbb798fK3w==
X-Proofpoint-Spam-Reason: orgsafe

On Wed, Jan 28, 2026 at 05:24:24PM +0000, Conor Dooley wrote:
> On Wed, Jan 28, 2026 at 04:52:01PM +0100, Krzysztof Kozlowski wrote:
> > On 28/01/2026 16:06, Conor Dooley wrote:
> > > On Wed, Jan 28, 2026 at 02:49:39PM +0200, Andy Shevchenko wrote:
> > >> On Wed, Jan 28, 2026 at 11:35:25AM +0100, Krzysztof Kozlowski wrote:
> > >>> On Tue, Jan 27, 2026 at 10:02:17AM -0600, Danny Kaehn wrote:
> > >>>> On Tue, Jan 27, 2026 at 08:47:48AM -0600, Danny Kaehn wrote:
> > >>>>> This is a USB HID device which includes an I2C controller and 8 GPIO pins.
> > >>>>>
> > >>>>> The binding allows describing the chip's gpio and i2c controller in DT,
> > >>>>> with the i2c controller being bound to a subnode named "i2c". This is
> > >>>>> intended to be used in configurations where the CP2112 is permanently
> > >>>>> connected in hardware.
> > >>>>>
> > >>>>> Signed-off-by: Danny Kaehn <danny.kaehn@plexus.com>
> > >>>>> ---
> > >>>>
> > >>>> Hi Folks (Intended for Rob or Krzysztof),
> > >>>>
> > >>>> Wasn't sure the best way to go about this, but trying to see the best
> > >>>> way to get a message in front of you regarding an ask from Andy S.
> > >>>>
> > >>>> In [1], Rob H initially directed that the gpio chip share a node with
> > >>>> the CP2112 itself, rather than having a subnode named 'gpio'.
> > >>>>
> > >>>> Initially, I did the same thing for both DT and ACPI, but Andy S.
> > >>>> directed that ACPI should not have the node be shared in that way.
> > >>>>
> > >>>> With the last revision of this patch, Andy S. asked that I try to get a
> > >>>> rationalle from Rob (or other DT expert presumably) on why the gpio node
> > >>>> should be combined with the parent, rather than being a named subnode
> > >>>> [2].
> > >>>
> > >>> Because it is explicitly asked in writing bindings. Please read it.
> > >>>
> > >>> Because we do not want Linux driver model affecting design of bindings
> > >>> and DTS, by subnodes present only to instantiate Linux drivers. I do not
> > >>> care about driver model in this review and I do not see any reason it
> > >>> should make DTS less obvious or readable.
> > >>>
> > >>> That's actually rule communicated many times, also documented in writing
> > >>> bindings and in recent talks.
> > >>
> > >> Does DT represents HW in this case? Shouldn't I²C controller be the same node?
> > >> Why not? This is inconsistent for the device that is multi-functional. And from
> > >> my understanding the firmware description (DT, ACPI, you-name-it) must follow
> > >> the HW. I don't see how it's done in this case.
> > > 
> > > The i2c controller should probably be in the same node too, unless it
> > > would cause conflicts between function (e.g. inability to figure out if
> > 
> > This one is the rationale.
> > 
> > > a child is a hog or a i2c device). I would like a rationale provided for
> > > why the i2c controller is in a subnode.
> 
> I guess it wasn't clear that I was trying to say that the rationale
> should be provided by the submitter in their patch, and the first
> portion of my comment was trying to mention what has to be considered.
>

Hello Conor,

Thanks for the comment -- as this binding was created, it was noted that 
it is somewhat of an oddball compared to existing bindings, so rationale
should have been provided somewhere, to justify whether those oddities
are needed because of this hardware being odd, or whether I was going
out of bounds. Would that have belonged in the initial patch series
message?

My rationale was this -- as has been mentioned by others, the i2c node
seems to be normalized as a separated submode because it does represent
a distinct bus, and it make sense to group the devices on that bus such
that the context of `reg` is aparrent (i.e. if there were multiple i2c
busses, they would necessarily need their own nodes). Initially when
creating this binding, I applied the same logic to the gpio chip,
observing the presence of the "hog" child nodes, and that their `gpios`
property also acts like `reg` on a bus, relating to the parent node.
But, now, seeing that that is already something that has been ruled not
to be the case, it makes sense to me why i2c busses might need their own
nodes while gpio chips might not.

Thanks,

Danny Kaehn


