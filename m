Received: from mx0b-0046e701.pphosted.com (mx0b-0046e701.pphosted.com [67.231.157.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 424A1340279;
	Wed, 21 Jan 2026 20:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.157.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769028947; cv=none; b=NF0l/RqFXC9imckug9ekt0kGzv2nCgC/Cp32f0/C30wrXAsy2sKXfClQXtUzIVCA7Xdy9HRw7JWEsoWIxPCIjlVKB2FMROfKHlFYT1qlOxvxB5ECPJGy1HqJ3hvptq3ilopW+OMThjFo7jvQN9gNCTra6LZUB8UmpukbEXAHfKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769028947; c=relaxed/simple;
	bh=shB/nOEZf0SYoyLaiDU22nArcNeEHHkYrPQXpXLOs1s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z4NQsPbldj8xtWre9sXxajh/2RJYEsN41Q680YS3r6DyVPfj3jmv5c1Rep5O4Rvxs+CVwhk++7vOPUM98vZFLzjQfA3Vf71qUCGCR03bmVBgQ+4QiqO9o4Iq4S3VPs53Ypo3ugUlWsWTZZswjC+U0zAXX7SfX5GSrcIP4EPenV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=plexus.com; spf=pass smtp.mailfrom=plexus.com; dkim=pass (2048-bit key) header.d=plexus.com header.i=@plexus.com header.b=FEBN5CCS; arc=none smtp.client-ip=67.231.157.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=plexus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=plexus.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=plexus.com header.i=@plexus.com header.b="FEBN5CCS"
Received: from pps.filterd (m0425992.ppops.net [127.0.0.1])
	by mx0b-0046e701.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60LINccc935887;
	Wed, 21 Jan 2026 14:42:18 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plexus.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pps1; bh=kMMai344yfdBNxNdwSNfQ16I3p0AQ
	MOlkHJ1FGcTdfw=; b=FEBN5CCSNlfloCBAtkAcdUPSsPRT3QQX9Zjf6itCthuLP
	EgTCSUxdrJilSo/0FSPSwTDstOi/Fmyyy3C0Ui8dAkCmfhkEwsbwGqainQFYRY9k
	bgvSzx1zDHN+0Yb0GT/Fw9//ddKicNElaeoKNtM2BYrF8Yh96DbF+7bVjJqmd9n4
	qh3/y2DRwX5M5gX1/mBSpYMaeK3ZGPpPJQN2YLvJvqTIL5XO1v/N+jrzkB9hZEWf
	Kvwvb1FBFlRURNr41WhksLhugbH0CcHELuHsLUA7Jh9RaALnweTbGu7Eqi1of/c9
	FyNnDvoNyJRpLe6NjvjMG1W5yu2jkH0Vc/ZTGIIPQ==
Received: from intranet-smtp.plexus.com ([64.215.193.254])
	by mx0b-0046e701.pphosted.com (PPS) with ESMTPS id 4btae3jyru-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 21 Jan 2026 14:42:17 -0600 (CST)
Received: from localhost (unknown [10.255.48.203])
	by intranet-smtp.plexus.com (Postfix) with ESMTP id D7E133C87A;
	Wed, 21 Jan 2026 14:42:16 -0600 (CST)
Date: Wed, 21 Jan 2026 14:38:45 -0600
From: Danny Kaehn <danny.kaehn@plexus.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
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
Subject: Re: [PATCH v12 2/3] HID: cp2112: Fwnode Support
Message-ID: <20260121203845.GA7162@LNDCL34533.neenah.na.plexus.com>
References: <20251126-cp2112-dt-v12-0-2cdba6481db3@plexus.com>
 <20251126-cp2112-dt-v12-2-2cdba6481db3@plexus.com>
 <aSdGh3i_KYocE3L3@smile.fi.intel.com>
 <20251126193251.GA269764@LNDCL34533.neenah.na.plexus.com>
 <aSdvv3Qss5oz_o6P@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aSdvv3Qss5oz_o6P@smile.fi.intel.com>
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIxMDE3MyBTYWx0ZWRfX4ptEQFKdvfEP
 aHBLwBp6qRd6jztlDhS7R5JlBSofX/GNbDJqvWjJBuik5y3i+5nfuqX/Oq/pV0oMNR3Uqvpx26k
 PNw/ChhLIZJn2SgcdMxHxUnLuMVZW9Ky2E7kHWhYFGCI4/2xnwzeiiv+QZ/aqRic2mR45waqnhQ
 CtTslosnbrF2kjyHsvqWqpC0D9Pimv8Ms34pUjrDrh4IkpLK7nu+O3Osi3dBZeeMHFzGcwrXpf5
 B/Lr4WM0Ldrh8VzU0T93zSvqIG8gY9EH028aZC4eEAoUkjRjKhpPEEytFxzrk9L8ZftnaFHOAef
 jgVULHwlGwclYmQkoTPOeYf5n0l/DWT3RUBK5sIFMwoOJN05Ehx35pV/5gKVjoyak5r9D3/zx7l
 FVrcNaJJb+C/ynBN0PQdwRhKkDAn/3VYmhgksr6gWqLCoG2o4OqWMCAm5Y/aD4od5Wc7kVeUqK2
 Ay1iCe/z7Jn291dqfmQ==
X-Authority-Analysis: v=2.4 cv=QcJrf8bv c=1 sm=1 tr=0 ts=69713a29 cx=c_pps
 a=356DXeqjepxy6lyVU6o3hA==:117 a=356DXeqjepxy6lyVU6o3hA==:17
 a=kj9zAlcOel0A:10 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=tAhwIOlm_SVqoVGHtKUA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: Ol9HgFKk7FHVl5mCE0V7C4XPjzoIwDnK
X-Proofpoint-ORIG-GUID: Q5Kkz-6HkIs5f-A0W5gg_agwLKFeBTgl
X-Proofpoint-Spam-Reason: orgsafe

Hi Andy,

Finally was able to perform the last tests needed before sending out
v13, but wanted to close the loop on your final questions from v12:

On Wed, Nov 26, 2025 at 11:23:11PM +0200, Andy Shevchenko wrote:
> On Wed, Nov 26, 2025 at 01:32:51PM -0600, Danny Kaehn wrote:
> > On Wed, Nov 26, 2025 at 08:27:19PM +0200, Andy Shevchenko wrote:
> > > On Wed, Nov 26, 2025 at 11:05:25AM -0600, Danny Kaehn wrote:
> > > > For ACPI, the i2c_adapter will use the child with _ADR Zero and the
> > > > gpio_chip will use the child with _ADR One. For DeviceTree, the
> > > > i2c_adapter will use the child with name "i2c", but the gpio_chip
> > > > will share a firmware node with the CP2112.
> > > 
> > > Hmm... Is there any explanation why DT decided to go that way?
> > 
> > I don't have an explanation, but Rob H. had directed that I make this
> > change in [1].
> > 
> > In v11, I then removed that child node for both ACPI and DT, hoping to
> > maintain unity, but you had directed that wouldn't be intuitive for ACPI
> > in [2].
> > 
> > Thus, in this v12, I have just entirely split the two, as it seemed
> > unlikely that any compromise to unify the schema between the two
> > firmware languages would be possible for a change/driver this
> > inconsquential to the overall kernel.
> 
> Even though, would be nice to try to get a rationale from Rob on this.
> Then we can put it in the commit message to explain. Otherwise it will
> confuse history diggers in the future.
>

Will attempt to see if I can get them to weigh in.

> ...
> 
> > > > +		device_set_node(&dev->adap.dev,
> > > > +			device_get_named_child_node(&hdev->dev, "i2c"));
> > > 
> > > Here we bump the reference count, where is it going to be dropped?
> > > 
> > > Note, in the other branch (ACPI) the reference count is not bumped in
> > > the current code.
> > 
> > Great point, forgot that I had dropped that handling in v9. The old
> > behavior was that the CP2112 driver maintained a reference to each node
> > during the lifetime of the device (and released during probe errors,
> > etc..). I'm still a bit confused as to whether that is correct or not,
> > or if the references should immediately be dropped once they're done
> > being parsed during probe()... My understanding previously was that I
> > should keep the reference count for the child fwnodes for the lifetime
> > of the CP2112, since the pointers to those are stored in the child
> > devices but would usually be managed by the parent bus-level code, does
> > that seem correct?
> 
> While there is a (theoretical) possibility to have lifetime of fwnode shorter
> than a device's, I don't think we have or ever will have such a practical
> example. So, assumption is that, the fwnode that struct device holds has
> the same or longer lifetime.
> 
> Note, I haven't investigated overlays (DT and ACPI) behaviour. IIRC you
> experimented with ACPI SSDT on this device, perhaps you can try to see
> what happens if there is a confirmed that the above is not only a theoretical
> problem.
> 
> TL;DR: I would drop reference count just after we got a respective fwnode.
> 

Finally got a chance to test this, attempting to apply SSDT overlays at
runtime via configfs to instantiate an I2C device on the CP2112's I2C
bus. I didn't dig terribly deep, but both with and without the fwnode
reference count bumped, the I2C device instantiation happened as
expected when loading the overlay. I'm sure there's more nuanced cases
and things to dig in here, but seems like leving those references
dropped is the right thing, as you say.



Thanks,

Danny Kaehn
