Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB4554A204F;
	Tue,  6 Oct 2026 18:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791312641; cv=none; b=r6/CN570K4Y7YcnyPI3WNut85xh3PYxLgE8nHvyCPXSF2p6pPBwO3qj9n4w1fAMTJCplOSktUULfjv4iAQSnqEryfexhuKssdqmh7jTOWmj/+pXpUoDLs8W8DN6xlQfeaDhzkH+C2HIPcGerbb3AoYKhaOklkBk/j2/KSVqWySE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791312641; c=relaxed/simple;
	bh=pAafaC7hBrqDElAgMvcvE6thWpIPEbnhcZP2tU/+WTg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IHjiR5Bs+pMNn9g3bn69LnXfUIrgY9Vnkjv3jgG79Sv737EtQ7V2/g4ldj9zRZgyjeMYnRhapkX+ZhQHaalRqEMRlWnLHrz2rRsnngiSQioK+7Z9mqk0YyuMrKm+CoKL1sdqR0pfkpGgokzbHhCe0MwOBAiubmo3L/I0FqcUXjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nqVtH0PD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nqVtH0PD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 258821F0089B;
	Tue,  6 Oct 2026 18:50:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791312640;
	bh=tXLSbpyUG31gTT+jrU2zP+FXGyzeEv4VmzVE/LaXxjY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=nqVtH0PDsADZHitSsB9NWX6JfSdnbWpCkPis74u/0eQ63jKclvt5x9BouQeAL7kPr
	 8ZusnzhuwxM4EYc3SKaoCz3/Qn3ZujK5jHZtdB3Smo+GYoy+pVIXJtUzesjicm7FC2
	 MEmscX1QmXDyp9yR/DlINPPGfK6bwhEccUyN68rL4c+Nm9IBGK4MA69p/6wLDZGTdF
	 nQXottDid1ozi9tFP6Jli6w//JVcmnFjNThZ5LaTmMuv+kwLLrjQW+bFTIZBRLgMWK
	 WjclFiJq1gqZGf13rs3vSt7mU51/uVUG4sBUKYEnJEsmJfKiJf7KA2EerfDEQjyXOs
	 ZRZJ0xUdNzSdA==
Date: Tue, 6 Oct 2026 13:50:39 -0500
From: Rob Herring <robh@kernel.org>
To: Yureka Lilian <yureka@cyberchaos.dev>
Cc: Michael Reeves <michael.reeves077@gmail.com>,
	Sven Peter <sven@kernel.org>, Janne Grunau <j@jannau.net>,
	Neal Gompa <neal@gompa.dev>, Jassi Brar <jassisinghbrar@gmail.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Hector Martin <marcan@marcan.st>,
	"Joerg Roedel (AMD)" <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>, asahi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, iommu@lists.linux.dev,
	linux-input@vger.kernel.org, Julian Braha <julianbraha@gmail.com>,
	Sasha Finkelstein <k@chaosmail.tech>
Subject: Re: [PATCH v4 04/10] dt-bindings: input: apple: Add DockChannel HID
 transport
Message-ID: <20261006185039.GE2194299-robh@kernel.org>
References: <20260925-apple-mtp-keyboard-final-v4-0-304c267518f4@gmail.com>
 <20260925-apple-mtp-keyboard-final-v4-4-304c267518f4@gmail.com>
 <20261006160049.GA2406717-robh@kernel.org>
 <2687bc3e-b73a-415c-8c68-8249e1fe4e6b@cyberchaos.dev>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2687bc3e-b73a-415c-8c68-8249e1fe4e6b@cyberchaos.dev>

On Tue, Oct 06, 2026 at 08:09:47PM +0200, Yureka Lilian wrote:
> 
> On 10/6/26 18:00, Rob Herring wrote:
> > On Fri, Sep 25, 2026 at 10:09:31PM +1000, Michael Reeves wrote:
> > [...]
> > > +
> > > +  mboxes:
> > > +    items:
> > > +      - description: ASC mailbox used for RTKit control
> > > +      - description: DockChannel FIFO mailbox used for HID packets
> > > +
> > > +  mbox-names:
> > > +    items:
> > > +      - const: asc
> > > +      - const: dockchannel
> > > +
> > > +  iommus:
> > > +    maxItems: 1
> > > +
> > > +  stm:
> > > +    type: object
> > > +    description:
> > > +      STM interface providing the vendor, product and version identifiers
> > > +      and serial number shared by the HID devices. When present, the host
> > > +      must query this interface before registering the keyboard.
> > > +    additionalProperties: false
> > An empty node is unusual. Why can't you just query the STM interface and
> > treat it not existing or having those properties the same as no 'stm'
> > node.
> 
> The issue is there is no indicator for the stm *not* being present: We boot
> the MTP coprocessor, and then receive a message when the stm is available.
> In that case we know it's ready and we can proceed with obtaining the serial
> numbers and registering the hid devices. But if there is no stm, we simply
> do not get the stm ready message, and the hid devices are never registered
> (this is the case in the original downstream Asahi dockchannel-hid). To make
> the stm optional *without* taking the information from the device tree, this
> would require some sort of timeout for waiting for the stm ready message. I
> outlined the available options in this thread[1] and argued the empty stm
> subnode makes sense, since this is describing a peripheral which may or may
> not be present (and this information is useful to initialize the device
> properly).
> 
> Link[1]: https://lore.kernel.org/asahi/bbaca769-312c-4a24-9524-16cb2b4f277f@cyberchaos.dev/

Okay, but you don't need a node here. Just an 'apple,has-stm' or similar 
property will suffice.

Rob

