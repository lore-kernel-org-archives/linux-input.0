Received: from mx0a-0046e701.pphosted.com (mx0a-0046e701.pphosted.com [67.231.149.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F56A14AD0D;
	Thu,  4 Jun 2026 14:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.149.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780583593; cv=none; b=W9zTBu0iHiXIJIZJg8OxIfg7UAmhhyzApYxaOL8C3FSydba6e3+lpEOAdfHkFGIQAu4A+q9HpIyjUcy0qTrqcEVb9dwo3JLBRF1r/mk777nKWqfNSgdY5r2GZgnUEsLmENmS0Vpp1nste7puh82X6x6KYSoR+/mfkB4Caf9RDT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780583593; c=relaxed/simple;
	bh=O5zIrXGdBjnWpDrkMtSSWVin/K5KwX4sQkCvSWzIuLY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aYH5SCiK6QP03oTl/DmWYzNVGWi0EyP/fNGNrNt1CYtLgkfcJLKs6snPwWXTrOK8V4S4ShZw2r4w6Qe9WprLTFp7iztTuLjJMUNFRD8zvVmPyFJ1PdED6bmM3UTvO2DMs9uK+59rvm+J8Rq2wgJ5msGsNwhqXbGPuh5Zi6paIP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=plexus.com; spf=pass smtp.mailfrom=plexus.com; dkim=pass (2048-bit key) header.d=plexus.com header.i=@plexus.com header.b=el2iYyC8; arc=none smtp.client-ip=67.231.149.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=plexus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=plexus.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=plexus.com header.i=@plexus.com header.b="el2iYyC8"
Received: from pps.filterd (m0425990.ppops.net [127.0.0.1])
	by mx0a-0046e701.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6548EYvV3475381;
	Thu, 4 Jun 2026 09:33:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plexus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps1; bh=5YLgT
	lzlyO1P3UBKcpNYt+WgO+SIKZKfby0xshoSnXA=; b=el2iYyC8aiL/ftlLrmzvT
	5CF4eJEDSODTTz0YFlFrSdKnUdwIF4ifPeyd+5NRHHQBwn8N5ezmoDP8BTp9Oq2U
	rQZG0EV9eVUt6ww9LZGN3umWXatpbO3hf2XyCjf2qjSxQzBimQD0MsXLTuAqQpp3
	R4KqgN/tc1tz4AuZMwzuLbX+nczNq3f+m6KTaRmXuwRvRe+S8V3Y0KoNlpYOxIuZ
	9eVNECKzD8PAhmqjr7UTAeS4iBX7lV0PqFryobQnvVbue1MEj1vZuIYdD8E98GCQ
	DQVfeHHwzWW4XdC3+uPl54UJAScNDAFFcK6f/F04gBFw7PDugWn3M2ndlUr4MBXP
	Q==
Received: from intranet-smtp.plexus.com ([64.215.193.254])
	by mx0a-0046e701.pphosted.com (PPS) with ESMTPS id 4ejswhsyx0-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 04 Jun 2026 09:33:06 -0500 (CDT)
Received: from localhost (unknown [10.255.48.203])
	by intranet-smtp.plexus.com (Postfix) with ESMTP id 19A7A6660B;
	Thu,  4 Jun 2026 09:33:05 -0500 (CDT)
Date: Thu, 4 Jun 2026 09:31:04 -0500
From: Danny Kaehn <danny.kaehn@plexus.com>
To: Benjamin Tissoires <bentiss@kernel.org>
Cc: sashiko-reviews@lists.linux.dev, dmitry.torokhov@gmail.com,
        linux-input@vger.kernel.org
Subject: Re: [PATCH v14 1/2] HID: cp2112: Add fwnode support
Message-ID: <20260604143104.GB1355442@LNDCL34533.neenah.na.plexus.com>
References: <20260520-cp2112-dt-v14-1-b1b4b6734b6f@plexus.com>
 <20260520170229.CEFA31F000E9@smtp.kernel.org>
 <ah6LJw5bgVyrtnyI@beelink>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ah6LJw5bgVyrtnyI@beelink>
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=DNq/JSNb c=1 sm=1 tr=0 ts=6a218ca2 cx=c_pps
 a=356DXeqjepxy6lyVU6o3hA==:117 a=356DXeqjepxy6lyVU6o3hA==:17
 a=8nJEP1OIZ-IA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=SL0Da4cj2IsybHzvybfz:22 a=C18UW36MDdOJqUei8wPZ:22 a=c92rfblmAAAA:8
 a=Y_joWELsAAAA:8 a=VwQbUJbxAAAA:8 a=HmVFj_zr6ouOCFTG7hMA:9 a=3ZKOabzyN94A:10
 a=wPNLvfGTeEIA:10 a=GvGzcOZaWPEFPQC_NcjD:22 a=g_BQsM8wYJVSTWLOHH1t:22
X-Proofpoint-GUID: JkZwu8Yx389vVUJA_vT9LZVj7bP_snJ8
X-Proofpoint-ORIG-GUID: p5uxUW7zAi_K1LYLquUMQWzhtqyhtsKE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA0MDE0MiBTYWx0ZWRfX3XFKRzg9HXnK
 VOUbcamwNvOykSaeOwT8RUzKSC2ZcQgzDbrp2M9vOYn4lPm7WOsUKkPWRs/plVXvW53sQYSTpSf
 h7BtVAfoBm3S5FdfgMMlCRB09pXj/FEUN+rhcpEiowWan0SepDb+MGE5t/AAvQBmQYyzc6TBOrU
 4C4STdG2M+yJFLvU6i2P4e7OJwR4QltYiyzBrb5JdynURIif01dkLbdxDsEULEMU85tDZmCc/eA
 E1O8TS+bX3a+G1jd8LIaatifeRBQhFLqpuRX//gaPf/k/Jp6mxACpdP2KsgBzXmn7kdLDmurQ8j
 5PkJ4Nvs2V4aY8Xq9bFXfL0aEvyEUztiaHNPh3ELBy2rsc5Mm8SxlFXS3qrBzepvQUfEnstuDMN
 9HoEThyflsSLKW0F9ipu1n8jDrXW//RXTWETHA6noejjM+qPrVRtwbOnPy4aDCxbyRCuWSlDVRs
 BKJAiz5KfdwJCjSYsBQ==
X-Proofpoint-Spam-Reason: orgsafe



On Tue, Jun 02, 2026 at 09:55:18AM +0200, Benjamin Tissoires wrote:
> On May 20 2026, sashiko-bot@kernel.org wrote:
> > Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> > - [High] Premature release of firmware node references results in use-after-free vulnerabilities when assigning the I2C adapter and GPIO chip firmware nodes.
> > --
> > 
> > commit 3dfaf368e855835bf23009205c4b93a2a070aae1
> > Author: Danny Kaehn <danny.kaehn@plexus.com>
> > 
> > HID: cp2112: Add fwnode support
> > 
> > This commit adds firmware node support to describe the CP2112's I2C and
> > GPIO interfaces. It differentiates between ACPI and DeviceTree bindings,
> > mapping the child nodes to the respective adapter and gpio_chip devices.
> > 
> > > diff --git a/drivers/hid/hid-cp2112.c b/drivers/hid/hid-cp2112.c
> > > index 803b883ae8750..e960fc988058f 100644
> > > --- a/drivers/hid/hid-cp2112.c
> > > +++ b/drivers/hid/hid-cp2112.c
> > [ ... ]
> > > @@ -1226,6 +1241,28 @@ static int cp2112_probe(struct hid_device *hdev, const struct hid_device_id *id)
> > >  		return ret;
> > >  	}
> > >  
> > > +	cp2112_fwnode = dev_fwnode(&hdev->dev);
> > > +	if (is_acpi_device_node(cp2112_fwnode)) {
> > > +		fwnode_for_each_child_node(cp2112_fwnode, child) {
> > > +			ret = acpi_get_local_address(ACPI_HANDLE_FWNODE(child), &addr);
> > > +			if (ret)
> > > +				continue;
> > > +
> > > +			switch (addr) {
> > > +			case CP2112_I2C_ADR:
> > > +				device_set_node(&dev->adap.dev, child);
> > > +				break;
> > > +			case CP2112_GPIO_ADR:
> > > +				dev->gc.fwnode = child;
> > > +				break;
> > > +			}
> > 
> > [Severity: High]
> > Does this code leave dangling pointers in the device structures?
> > 
> > The fwnode_for_each_child_node() macro automatically drops the reference to
> > the child node when advancing to the next node or exiting the loop.
> > 
> > Because device_set_node() and direct pointer assignments do not increment
> > the reference count, the nodes assigned here could be prematurely freed
> > resulting in a use-after-free.
> 
> Sashiko is overly cautious here. ACPI handles are not refcounted, so we
> are fine.
> 
> That being said, we could unify the OF and ACPI behaviour by calling the
> noops fwnode_handle_get(child) for ACPI as well and clean them up in
> cp2112_remove(). This would also shut up the next warning from Sashiko
> below.
> 
> > 
> > > +		}
> > > +	} else if (is_of_node(cp2112_fwnode)) {
> > > +		child = fwnode_get_named_child_node(cp2112_fwnode, "i2c");
> > > +		device_set_node(&dev->adap.dev, child);
> > > +		fwnode_handle_put(child);
> > 
> > [Severity: High]
> > Are we releasing the firmware node prematurely here?
> > 
> > fwnode_get_named_child_node() returns a node with an incremented reference
> > count. However, since device_set_node() does not take its own reference on
> > the child node, dropping the reference immediately after could leave
> > dev->adap.dev with a dangling pointer if the node is later removed.
> 
> OF children are tied to the lifespan of the OF device, so we are fine,
> but technically incorrect, as mentioned by Sashiko.
> 
> If you regroup the 2 behaviours and clean them in cp2112_remove(), this
> would be cleaner IMO.
>

Ack, this is something I've gone back-and-forth on in the revisions of
this patch. Will update the driver to hold the fwnode reference for the
I2C subnode.

However, for the GPIO chip, DT uses the parent node (which shouldn't
need an increment to the refcount), while ACPI uses a child node. Given
this discussion, it sounds like I ought to still increment the refcount
for the GPIO child node to comply to the interface, even though ACPI
handles aren't refcounted. This will require another bit of DT/ACPI
diverging behavior in _remove(), which is fine by me, just announcing
that intent in case it doesn't match your expectation / might appear as
a code smell in the follow-up patch.




> Cheers,
> Benjamin
> 
> > -- 
> > Sashiko AI review · https://sashiko.dev/#/patchset/20260520-cp2112-dt-v14-0-b1b4b6734b6f@plexus.com?part=1

Thanks,

Danny Kaehn

