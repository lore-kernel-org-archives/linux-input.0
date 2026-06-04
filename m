Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD81C480346;
	Thu,  4 Jun 2026 14:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780584109; cv=none; b=d9PnH+Vi6DRqWtbFmStKN02IG6Jnz+nAyBDaLPp7UyM4Pqr7TopTwLKo9wiHFP8utcySKAGIrXeaP26OXsU3huqmvVQ78qRn28NGAKmT47AvxBZzqJW3M0bmCgywQlPmXUZmYQxKUl8yMS7kGqzXjABLENL/wvSE8cwt5k4a+EQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780584109; c=relaxed/simple;
	bh=IZUyeHpEUiDBY1eTrI7fDkU8pJLG9YW9Z3nCBg2piHg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ebV9oW7q31LYjn0UlHQOIb2k+HgmegZcjbfpfjk71RPQTnVtu4JgtY3FneWmgr0wMuW1b3SgGjLhva8XX2BxtCVOBxYKrMe+TFjP91bgAkEdU+EGbrePohXGQiBn90C7gcbTWijn3tu3L9JiNGm3lXzKmHtMoAPDrZ15ZLrtDMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T/2IrbBC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T/2IrbBC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C31FC1F00893;
	Thu,  4 Jun 2026 14:41:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780584107;
	bh=HBDFAOUIf06+kgPr/KpezRch+RnqzzpEdLRUW3CWOoY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=T/2IrbBCCqRk8eGWYpDY8mS3C2xilWw6y9J/9+4SQIsUUqRVnF05mKwdrZi1JaW2k
	 S68vieM8Dhy5vH+pJZfq+FADLixfKvesdJKPTHV+X89eWRi3oUhcFKvD4jQMNak0Pk
	 12WffE1rWCtRG0eA2gJ3HC6OjPopcE7Ofm55nOGMYaVWVPfzyqM4NdK7i8p1jkX+oW
	 hTl3QOUDXvFCn5CBwN9IkVX/z86AcR4D3O+KIuoTN2bE2kl1JN2p70xyLgLEZuwZYi
	 vXrkRBm1HgmXHm29PmF4yEIYqVloCBabuKYlaSWC4wqQKHnfHP00OoZkUTyi370DeX
	 Lpe4PlOW3SB+w==
Date: Thu, 4 Jun 2026 16:41:43 +0200
From: Benjamin Tissoires <bentiss@kernel.org>
To: Danny Kaehn <danny.kaehn@plexus.com>
Cc: sashiko-reviews@lists.linux.dev, dmitry.torokhov@gmail.com, 
	linux-input@vger.kernel.org
Subject: Re: [PATCH v14 1/2] HID: cp2112: Add fwnode support
Message-ID: <aiGNkO9nFF4mF7vB@beelink>
References: <20260520-cp2112-dt-v14-1-b1b4b6734b6f@plexus.com>
 <20260520170229.CEFA31F000E9@smtp.kernel.org>
 <ah6LJw5bgVyrtnyI@beelink>
 <20260604143104.GB1355442@LNDCL34533.neenah.na.plexus.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260604143104.GB1355442@LNDCL34533.neenah.na.plexus.com>

On Jun 04 2026, Danny Kaehn wrote:
> 
> 
> On Tue, Jun 02, 2026 at 09:55:18AM +0200, Benjamin Tissoires wrote:
> > On May 20 2026, sashiko-bot@kernel.org wrote:
> > > Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> > > - [High] Premature release of firmware node references results in use-after-free vulnerabilities when assigning the I2C adapter and GPIO chip firmware nodes.
> > > --
> > > 
> > > commit 3dfaf368e855835bf23009205c4b93a2a070aae1
> > > Author: Danny Kaehn <danny.kaehn@plexus.com>
> > > 
> > > HID: cp2112: Add fwnode support
> > > 
> > > This commit adds firmware node support to describe the CP2112's I2C and
> > > GPIO interfaces. It differentiates between ACPI and DeviceTree bindings,
> > > mapping the child nodes to the respective adapter and gpio_chip devices.
> > > 
> > > > diff --git a/drivers/hid/hid-cp2112.c b/drivers/hid/hid-cp2112.c
> > > > index 803b883ae8750..e960fc988058f 100644
> > > > --- a/drivers/hid/hid-cp2112.c
> > > > +++ b/drivers/hid/hid-cp2112.c
> > > [ ... ]
> > > > @@ -1226,6 +1241,28 @@ static int cp2112_probe(struct hid_device *hdev, const struct hid_device_id *id)
> > > >  		return ret;
> > > >  	}
> > > >  
> > > > +	cp2112_fwnode = dev_fwnode(&hdev->dev);
> > > > +	if (is_acpi_device_node(cp2112_fwnode)) {
> > > > +		fwnode_for_each_child_node(cp2112_fwnode, child) {
> > > > +			ret = acpi_get_local_address(ACPI_HANDLE_FWNODE(child), &addr);
> > > > +			if (ret)
> > > > +				continue;
> > > > +
> > > > +			switch (addr) {
> > > > +			case CP2112_I2C_ADR:
> > > > +				device_set_node(&dev->adap.dev, child);
> > > > +				break;
> > > > +			case CP2112_GPIO_ADR:
> > > > +				dev->gc.fwnode = child;
> > > > +				break;
> > > > +			}
> > > 
> > > [Severity: High]
> > > Does this code leave dangling pointers in the device structures?
> > > 
> > > The fwnode_for_each_child_node() macro automatically drops the reference to
> > > the child node when advancing to the next node or exiting the loop.
> > > 
> > > Because device_set_node() and direct pointer assignments do not increment
> > > the reference count, the nodes assigned here could be prematurely freed
> > > resulting in a use-after-free.
> > 
> > Sashiko is overly cautious here. ACPI handles are not refcounted, so we
> > are fine.
> > 
> > That being said, we could unify the OF and ACPI behaviour by calling the
> > noops fwnode_handle_get(child) for ACPI as well and clean them up in
> > cp2112_remove(). This would also shut up the next warning from Sashiko
> > below.
> > 
> > > 
> > > > +		}
> > > > +	} else if (is_of_node(cp2112_fwnode)) {
> > > > +		child = fwnode_get_named_child_node(cp2112_fwnode, "i2c");
> > > > +		device_set_node(&dev->adap.dev, child);
> > > > +		fwnode_handle_put(child);
> > > 
> > > [Severity: High]
> > > Are we releasing the firmware node prematurely here?
> > > 
> > > fwnode_get_named_child_node() returns a node with an incremented reference
> > > count. However, since device_set_node() does not take its own reference on
> > > the child node, dropping the reference immediately after could leave
> > > dev->adap.dev with a dangling pointer if the node is later removed.
> > 
> > OF children are tied to the lifespan of the OF device, so we are fine,
> > but technically incorrect, as mentioned by Sashiko.
> > 
> > If you regroup the 2 behaviours and clean them in cp2112_remove(), this
> > would be cleaner IMO.
> >
> 
> Ack, this is something I've gone back-and-forth on in the revisions of
> this patch. Will update the driver to hold the fwnode reference for the
> I2C subnode.
> 
> However, for the GPIO chip, DT uses the parent node (which shouldn't
> need an increment to the refcount), while ACPI uses a child node. Given

Oh, if they are different, then maybe following that advice is not such
a good idea.

> this discussion, it sounds like I ought to still increment the refcount
> for the GPIO child node to comply to the interface, even though ACPI
> handles aren't refcounted.

Yeah, sashiko says that this is harmless and would provide symetrical
behavior (but artificial)

> This will require another bit of DT/ACPI
> diverging behavior in _remove(), which is fine by me, just announcing
> that intent in case it doesn't match your expectation / might appear as
> a code smell in the follow-up patch.

I thought you would just deref the stored node, so it doesn't matter
whether the original node is a parent or a child. Especially because it
would be a noop for ACPI.

But if there are no way of having a single fwnode_handle_put(node) (per
ref, of course), then maybe we can stick to the current code.

We should probably fix the other speed downgrade from 2/2.

Cheers,
Benjamin

> 
> 
> 
> 
> > Cheers,
> > Benjamin
> > 
> > > -- 
> > > Sashiko AI review � https://sashiko.dev/#/patchset/20260520-cp2112-dt-v14-0-b1b4b6734b6f@plexus.com?part=1
> 
> Thanks,
> 
> Danny Kaehn
> 
> 
