Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AECC2D6E66;
	Tue,  2 Jun 2026 07:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780386923; cv=none; b=T8dcV36NyUmEhKwTgJysx8oqEXXSBpKLzXrmXJbxf4JcVaVEO8/TU802yKT3J7z+ruSy6Xy5raBYRRzrEGaFB8cdIq+Ud9ASHQpfcNVZWIEZ5+DHJgJuJyDiP4LO2fj75cL0yjpyEU2/RmJbfPQJcwTFZtzn92tmEgIvvg5Jt6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780386923; c=relaxed/simple;
	bh=+sN6zpdyOriXPsnZU12ENPS+DNo75xefbvKGq6qCAIY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FPHfLTpY+8bgr+rh4pEVikWZTEGLVOb+DJWcaVhdUjwjUbW2vwpFwlaiQI5BgB11PFFpvMG0dC0vEr0Dq/eEWK65oz5DplTpujhcOKmXbuU9p7i6LgeGd/FwcmJCLYi/XF/XuwLFpsOP0P9WqHcnHl8MOTN64m5lXqVsk2gnZ3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=loPyPs+I; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="loPyPs+I"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58F6A1F00893;
	Tue,  2 Jun 2026 07:55:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780386922;
	bh=dhcwDr+/sqdcNLo5+3Szbnc8VATvExtO2SZeE9jrkw4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=loPyPs+IW/GaVzmRT/KhS6ca2s4Wxx4sLY9Nz6Eal7ZNIKsXeOeDPzcBhpi4Zv710
	 qwWuZq+hXCen+3WXaZ0J/Bz3mWWRaTbn+tFMa729/lJm5oq4EubIoos++D8mxXZRP+
	 Y17yOlYwSvQ2urWU+VLyLtoqCwWqOHwAo3PD3lCGYJBeOcRNe6gMmG/ixe+lLsuNWE
	 Hb636KUUKfmYi+X7oBzO/MOgqzSe05599QouOcabPqQAmpni4Gkmqfqls2xvabT3Qn
	 P6ItzWtrBQ5bCyh/j+Gy6a5s0KgNuAjV/EiU3Kuc5bre8mDlkrdWifqxlclUZQNc3h
	 duo1bXC+4fSZA==
Date: Tue, 2 Jun 2026 09:55:18 +0200
From: Benjamin Tissoires <bentiss@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: Danny Kaehn <danny.kaehn@plexus.com>, dmitry.torokhov@gmail.com, 
	linux-input@vger.kernel.org
Subject: Re: [PATCH v14 1/2] HID: cp2112: Add fwnode support
Message-ID: <ah6LJw5bgVyrtnyI@beelink>
References: <20260520-cp2112-dt-v14-1-b1b4b6734b6f@plexus.com>
 <20260520170229.CEFA31F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260520170229.CEFA31F000E9@smtp.kernel.org>

On May 20 2026, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] Premature release of firmware node references results in use-after-free vulnerabilities when assigning the I2C adapter and GPIO chip firmware nodes.
> --
> 
> commit 3dfaf368e855835bf23009205c4b93a2a070aae1
> Author: Danny Kaehn <danny.kaehn@plexus.com>
> 
> HID: cp2112: Add fwnode support
> 
> This commit adds firmware node support to describe the CP2112's I2C and
> GPIO interfaces. It differentiates between ACPI and DeviceTree bindings,
> mapping the child nodes to the respective adapter and gpio_chip devices.
> 
> > diff --git a/drivers/hid/hid-cp2112.c b/drivers/hid/hid-cp2112.c
> > index 803b883ae8750..e960fc988058f 100644
> > --- a/drivers/hid/hid-cp2112.c
> > +++ b/drivers/hid/hid-cp2112.c
> [ ... ]
> > @@ -1226,6 +1241,28 @@ static int cp2112_probe(struct hid_device *hdev, const struct hid_device_id *id)
> >  		return ret;
> >  	}
> >  
> > +	cp2112_fwnode = dev_fwnode(&hdev->dev);
> > +	if (is_acpi_device_node(cp2112_fwnode)) {
> > +		fwnode_for_each_child_node(cp2112_fwnode, child) {
> > +			ret = acpi_get_local_address(ACPI_HANDLE_FWNODE(child), &addr);
> > +			if (ret)
> > +				continue;
> > +
> > +			switch (addr) {
> > +			case CP2112_I2C_ADR:
> > +				device_set_node(&dev->adap.dev, child);
> > +				break;
> > +			case CP2112_GPIO_ADR:
> > +				dev->gc.fwnode = child;
> > +				break;
> > +			}
> 
> [Severity: High]
> Does this code leave dangling pointers in the device structures?
> 
> The fwnode_for_each_child_node() macro automatically drops the reference to
> the child node when advancing to the next node or exiting the loop.
> 
> Because device_set_node() and direct pointer assignments do not increment
> the reference count, the nodes assigned here could be prematurely freed
> resulting in a use-after-free.

Sashiko is overly cautious here. ACPI handles are not refcounted, so we
are fine.

That being said, we could unify the OF and ACPI behaviour by calling the
noops fwnode_handle_get(child) for ACPI as well and clean them up in
cp2112_remove(). This would also shut up the next warning from Sashiko
below.

> 
> > +		}
> > +	} else if (is_of_node(cp2112_fwnode)) {
> > +		child = fwnode_get_named_child_node(cp2112_fwnode, "i2c");
> > +		device_set_node(&dev->adap.dev, child);
> > +		fwnode_handle_put(child);
> 
> [Severity: High]
> Are we releasing the firmware node prematurely here?
> 
> fwnode_get_named_child_node() returns a node with an incremented reference
> count. However, since device_set_node() does not take its own reference on
> the child node, dropping the reference immediately after could leave
> dev->adap.dev with a dangling pointer if the node is later removed.

OF children are tied to the lifespan of the OF device, so we are fine,
but technically incorrect, as mentioned by Sashiko.

If you regroup the 2 behaviours and clean them in cp2112_remove(), this
would be cleaner IMO.

Cheers,
Benjamin

> 
> > +	}
> > +
> >  	ret = hid_parse(hdev);
> >  	if (ret) {
> >  		hid_err(hdev, "parse failed\n");
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260520-cp2112-dt-v14-0-b1b4b6734b6f@plexus.com?part=1
> 
