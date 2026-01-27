Received: from mx0b-0046e701.pphosted.com (mx0b-0046e701.pphosted.com [67.231.157.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBA552FE598;
	Tue, 27 Jan 2026 16:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.157.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769529981; cv=none; b=UmlXO912kQO1J9sTyfeUTeZAfPv2lFYQ4Itqjs3v9OSb+yg5EjKlyy9ZNuJ7S34i1s4SBuJVZDdKcpmhCHbugJ/mo3qZgqD2gSxbaBIaQZ984E3U3thlfgJFveCTrWbw8AZykQ5OySUPmYl4VrVSYbU8z5q+ibwkHgt2G6sWRms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769529981; c=relaxed/simple;
	bh=tFCRa3KnZWUkSKFCupr+j+drsSozAGTz6moKQZuAGqA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lx6dSQyWAQjgDMOmHDaPkcB4hxmInrLVNRfCP4zadtY25Y3zYEgljr4X+XL0IDPvhLo3WCHYgdTbDNczP9TQYwvgBJLlLD9BP7GrEYL0s0JUMjm7OtKXl/Lulvi92IoKVk2p3fBFGBc3ImIYCvOmOOtyksq+RaRdeXjawXjPn+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=plexus.com; spf=pass smtp.mailfrom=plexus.com; dkim=pass (2048-bit key) header.d=plexus.com header.i=@plexus.com header.b=DOyO9SDq; arc=none smtp.client-ip=67.231.157.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=plexus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=plexus.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=plexus.com header.i=@plexus.com header.b="DOyO9SDq"
Received: from pps.filterd (m0425993.ppops.net [127.0.0.1])
	by mx0b-0046e701.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60R3ZvNf2408879;
	Tue, 27 Jan 2026 10:06:08 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plexus.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pps1; bh=D/suHw5JTVQFP6YIK5Ggk4hT6MzIx
	dW4DQLULI0Yq24=; b=DOyO9SDqunQvM+rySbNG/ZIM9CebtHPp5TGDh2ukKfvx0
	5i7NxwljQ+pApFFKcooB8GBlZno0UQ6NJprjfdoIb3FDwenG1Kxos635Wot1qGys
	4zmhq3jyDZ0fKGFAAQDZztDLFii6ZjEty+1l6WKEsRg47jV8VYyT08JfPUdO8e9I
	1BLQaF/PJoCWimTGCnO0t4CDx41iOkokeEt8eTJDg0hMJVtmXZj3I1dVGBVr4GEZ
	1CZHosmygt6UuY85YYnZSM1kPi52Vy+YadsD+7+h8yQ3iRCUvCwTMveHIcP4Qajd
	cegs6tr+2XYBerajn1JcWtzbmSI99wfMkobvTIhWw==
Received: from intranet-smtp.plexus.com ([64.215.193.254])
	by mx0b-0046e701.pphosted.com (PPS) with ESMTPS id 4bwe1vc60t-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 27 Jan 2026 10:06:07 -0600 (CST)
Received: from localhost (unknown [10.255.48.203])
	by intranet-smtp.plexus.com (Postfix) with ESMTP id D1111580C1;
	Tue, 27 Jan 2026 10:06:06 -0600 (CST)
Date: Tue, 27 Jan 2026 10:02:17 -0600
From: Danny Kaehn <danny.kaehn@plexus.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Benjamin Tissoires <bentiss@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andi Shyti <andi.shyti@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Cc: Jiri Kosina <jikos@kernel.org>, devicetree@vger.kernel.org,
        linux-input@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Ethan Twardy <ethan.twardy@plexus.com>, linux-i2c@vger.kernel.org,
        linux-kernel@vger.kernel.org, Leo Huang <leohu@nvidia.com>,
        Arun D Patil <arundp@nvidia.com>, Willie Thai <wthai@nvidia.com>,
        Ting-Kai Chen <tingkaic@nvidia.com>
Subject: Re: [PATCH v13 1/3] dt-bindings: i2c: Add CP2112 HID USB to SMBus
 Bridge
Message-ID: <20260127160217.GA3776731@LNDCL34533.neenah.na.plexus.com>
References: <20260127-cp2112-dt-v13-0-6448ddd4bf22@plexus.com>
 <20260127-cp2112-dt-v13-1-6448ddd4bf22@plexus.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260127-cp2112-dt-v13-1-6448ddd4bf22@plexus.com>
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=c6CmgB9l c=1 sm=1 tr=0 ts=6978e26f cx=c_pps
 a=356DXeqjepxy6lyVU6o3hA==:117 a=356DXeqjepxy6lyVU6o3hA==:17
 a=kj9zAlcOel0A:10 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=QyXUC8HyAAAA:8 a=Y_joWELsAAAA:8 a=1liyV6abj2hmQ9BcVj4A:9
 a=CjuIK1q_8ugA:10 a=g_BQsM8wYJVSTWLOHH1t:22
X-Proofpoint-ORIG-GUID: 1b_HruHKb5KIa2jiJ9jkJjWhYgaLWRM8
X-Proofpoint-GUID: eloi-HR8t2tpFdWQbAr5vUDmv0DB8XpF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI3MDEzMSBTYWx0ZWRfXyKcNuXE/uCTf
 h8hFatzZfc6WRWgK5v1WHr03mt4h+v/Z5ircAUSx7mi0c50jRf1XE78PBjqOrsRh2iMQGi475XM
 +ZE7aXxR3N2bXKgvulf/JpwSaMCi+FjCLzb/s0oHipoS6uPBsnGjRoikx7koietFKBREDmOmv/F
 W61UI44w7sNsAuOxzHrEnkpa0ilkRZLK3L/0gE8RYTPzdaivP7lwxVyE1kDyYblW9Tv9oxya+N7
 UcNXvMCR/qwPFB8NI4y8tYCtueQSAzhuzMjI64xQo604la5WGWmChnuSmZCq9rLWWl5kXVkg+rw
 OMJMfL/+e3ij/Fbt6tCU9i60KfNVJ1diI66zytqNfoBq2gxh7wUX6nigLjReG7VAcRArzQb/b95
 +70Srccqy+qBqX2NuwXO+mXuZgoA7A1WLxbx25zPyCG0DVkZzWpNKv0HT93CW0/Uqi0j6UNSDVJ
 2dgT2GwFNzLCNn+Bcng==
X-Proofpoint-Spam-Reason: orgsafe

On Tue, Jan 27, 2026 at 08:47:48AM -0600, Danny Kaehn wrote:
> This is a USB HID device which includes an I2C controller and 8 GPIO pins.
> 
> The binding allows describing the chip's gpio and i2c controller in DT,
> with the i2c controller being bound to a subnode named "i2c". This is
> intended to be used in configurations where the CP2112 is permanently
> connected in hardware.
> 
> Signed-off-by: Danny Kaehn <danny.kaehn@plexus.com>
> ---

Hi Folks (Intended for Rob or Krzysztof),

Wasn't sure the best way to go about this, but trying to see the best
way to get a message in front of you regarding an ask from Andy S.

In [1], Rob H initially directed that the gpio chip share a node with
the CP2112 itself, rather than having a subnode named 'gpio'.

Initially, I did the same thing for both DT and ACPI, but Andy S.
directed that ACPI should not have the node be shared in that way.

With the last revision of this patch, Andy S. asked that I try to get a
rationalle from Rob (or other DT expert presumably) on why the gpio node
should be combined with the parent, rather than being a named subnode
[2].

Any context you can provide would be extremely helpful. Apologies about
the age of this patch series and the amount of historical context; some
is due to my long delays between revisions, but other of it is due to
attempting to get the ACPI and DT folks to talk / agree.

[1]: https://lore.kernel.org/all/20240213152825.GA1223720-robh@kernel.org/
[2]: https://lore.kernel.org/all/aSdvv3Qss5oz_o6P@smile.fi.intel.com/


Thanks,

Danny Kaehn

