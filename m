Received: from mx0a-0046e701.pphosted.com (mx0a-0046e701.pphosted.com [67.231.149.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC2133093AB;
	Thu, 29 Jan 2026 19:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.149.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769713757; cv=none; b=WxH0jUurMP3zQjiE4cr0EqBplpPTWkgMNobK4OgxQDGook/epj7h87cYtbFEg5PYX3FFIpjDQEdtkRoLZqCf1mi+tuLeAExg4Jiv4AeAPQVDY4mSvtTRPBdv9Wq+7EVMWwibRAyP/cjgU7FsUXGwPQ5MS6H22fY8gYoVk+6U9lc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769713757; c=relaxed/simple;
	bh=KeYYVI84auowcJei0ORIpUIn6i8G3rs8bWdf5GCc1IQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=etRgq9vjK2g6rtAVGzm187x8z7aFnXgJLJSOVBGyYObrv2TVKvlEjUSolQou3VWRJeGVULxsiT1OVFKwjYa0jobfxH7mqLIlrQ/doQ+wWB2PEMALE4Na97WX53/o3A+XT+II4uwOnQRux+TQBaipMHL6pnAigbF73zRtbR4mSUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=plexus.com; spf=pass smtp.mailfrom=plexus.com; dkim=pass (2048-bit key) header.d=plexus.com header.i=@plexus.com header.b=o7RyiDFa; arc=none smtp.client-ip=67.231.149.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=plexus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=plexus.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=plexus.com header.i=@plexus.com header.b="o7RyiDFa"
Received: from pps.filterd (m0425990.ppops.net [127.0.0.1])
	by mx0a-0046e701.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60TEMLuV3642470;
	Thu, 29 Jan 2026 12:40:48 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plexus.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pps1; bh=8e7W+WouVmIJSwHAZcMNZMVOk2Deo
	aRvTRmwd0eQlHY=; b=o7RyiDFakBExhgVjEC2H1mjW7kFmyIaIs/d2rQZRvDHPa
	1ggQ2yKNDkz8wM2XfZ8V1IoMH07fiFe69Jdbi3p+fvqpLj/xliiJowgbXkUfg2I6
	II3xlKQ8jvRtAC4mJ1t91kJiG6y6GzTf1s6LdZWhkz+MfkZrqdQZPYiRFlnGIRp+
	a72+4dTmrJbJYqvm0icRk/WoxdEbEdZpCUoewPCCBpg/PyZuF5BttK5RcxtxCjdE
	tYgwGkos1auAp1Y3/2ebTaAEZzfWcikUyx6tB5D/SQ3LdI3JWzU1MSyCOigRABdZ
	dozpT8JPiH2GPhNbSSCTNY1XDJJ3Em80RMEvytvEA==
Received: from intranet-smtp.plexus.com ([64.215.193.254])
	by mx0a-0046e701.pphosted.com (PPS) with ESMTPS id 4byy3nhnvd-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 29 Jan 2026 12:40:47 -0600 (CST)
Received: from localhost (unknown [10.255.48.203])
	by intranet-smtp.plexus.com (Postfix) with ESMTP id AC579580C3;
	Thu, 29 Jan 2026 12:40:46 -0600 (CST)
Date: Thu, 29 Jan 2026 12:36:50 -0600
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
Subject: Re: [PATCH v13 2/3] HID: cp2112: Fwnode Support
Message-ID: <20260129183650.GA1419235@LNDCL34533.neenah.na.plexus.com>
References: <20260127-cp2112-dt-v13-0-6448ddd4bf22@plexus.com>
 <20260127-cp2112-dt-v13-2-6448ddd4bf22@plexus.com>
 <aXkawwpmLW7m4Fu8@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aXkawwpmLW7m4Fu8@smile.fi.intel.com>
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI5MDEzMyBTYWx0ZWRfX6PW5eCMqP6et
 ruDl/u2GCBl5CYBy5izFti8X69dHAxGt0srQgZd3FCQZb+S3Mi2NoGIAadEbBMO5rjxEP0TxAAi
 TMh9Tck4pLpug4Dgtpn9Wkwz1QWOJECkjKxTRQDkyiU/7CXq5beXIfVdgfv9T7yGnRq0IilvaNG
 VIYsoioxlp3fsOzjKgeepiRQfsXBLfw6djYUFQxNarSMYNMzamnlRapzPDwT/L9gYK0hjgp30ir
 ZqsKIVEPy0jBhqg6Mx2FDaUMOwr2evpV+3y+MSDzTBkoKjRgod+jZyXRytx97W9jbDza9iKbLn8
 /uWvOwlqHtuneR9rr240WYETmb+OVM3bAx1C5uuq4HBpte96XI2ObWyiAh62KIOQY4BTgJ1PmFB
 fvcsz0m7uVcR7g9+91hvpXSE/8ngZ9fYWUqHjEbPHAV1b+RNm8OOHQmIsWobC8yAcI39eiuISXs
 lMC+cR9CRk1WbV8xaJw==
X-Proofpoint-GUID: EJ9cydMtKH1qcYAWVzXnwxlZhzNzn8AL
X-Authority-Analysis: v=2.4 cv=ZewQ98VA c=1 sm=1 tr=0 ts=697ba9af cx=c_pps
 a=356DXeqjepxy6lyVU6o3hA==:117 a=356DXeqjepxy6lyVU6o3hA==:17
 a=kj9zAlcOel0A:10 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=AXHH-QlhN15DAQ8XkFIA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: TFKHbqwEmM1otgO_Chofbbp0oEpBb8KX
X-Proofpoint-Spam-Reason: orgsafe

On Tue, Jan 27, 2026 at 10:06:27PM +0200, Andy Shevchenko wrote:
> On Tue, Jan 27, 2026 at 08:47:49AM -0600, Danny Kaehn wrote:
> > Support describing the CP2112's I2C and GPIO interfaces in firmware.
> > 
> > Bindings between the firmware nodes and the functions of the device
> > are distinct between ACPI and DeviceTree.
> > 
> > For ACPI, the i2c_adapter will use the child with _ADR Zero and the
> 
> _ADR equals to Zero
>
Ack, will change.

> > gpio_chip will use the child with _ADR One. For DeviceTree, the
> 
> _ADR equals to One
> 

Ack, will change.

> > i2c_adapter will use the child with name "i2c", but the gpio_chip
> > will share a firmware node with the CP2112.
> 
> ...
> 
> Also it's interesting choice of capital letters in the Subject.
> 
> I would expect "...: Add fwnode support"
> 

Ack, will change.

> ...
> 
> > +/**
> > + * enum cp2112_child_acpi_cell_addrs - Child ACPI addresses for CP2112 sub-functions
> > + * @CP2112_I2C_ADR: Address for I2C node
> > + * @CP2112_GPIO_ADR: Address for GPIO node
> 
> Probably you want to mention in the description of the enum (here) that
> the assigned values are explicit since this is basically a protocol between
> FW and OS. That's why we may not change this values without breaking
> older firmware descriptions.
> 
> > + */
> > +enum cp2112_child_acpi_cell_addrs {
> > +	CP2112_I2C_ADR = 0,
> > +	CP2112_GPIO_ADR = 1,
> > +};
> 
> ...
> 
> > +	if (is_acpi_device_node(dev_fwnode(&hdev->dev))) {
> 
> I'm wondering if we can avoid this (additional) check and use the result of one
> of the branches.
>

Meaning something like using the result of acpi_get_local_address() to
determine whether the node is ACPI vs. not? That is what it used to do,
before I needed to switch to different schemas for DT vs. ACPI. Now, it
doesn't really make sense to use the child node types to determine
whether the GPIO node is shared, but still possible if we store a bool
result from the *_for_each_child_node() loop, but needs more complex
logic to store that based on each child's type (and the loop is fully
unnecessary for the non-ACPI case anyways).


Following the discussion on the DT binding thread, do you still want
ACPI to follow this different schema with the separate GPIO child node,
or would you prefer to unify them?

> > +		device_for_each_child_node(&hdev->dev, child) {
> 
> If we are still use the above check it will be dev_fwnode() duplication call,
> so perhaps a temporary variable to collect the device's fwnode and use it
> there, below (see below), and here as for
> 
> 		fwnode_for_each_child_node()
>

Makes sense, will update. I initially assumed we wanted to use the
"device_*" API wherever possible.

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
> > +		}
> > +	} else {
> 
> I would still check if this is a proper (OF) node, in case we stick with the
> ACPI check above. Because we might have swnode and if it triggers, it will be
> really something unexpected.
>
> 	} else if (is_of_node(fwnode)) {
>

Wouldn't it be valid to use software nodes to describe the
CP2112's functions? Is there any reason to intentionally prevent that?

>
> > +		child = device_get_named_child_node(&hdev->dev, "i2c");
> > +		device_set_node(&dev->adap.dev, child);
> > +		fwnode_handle_put(child);
> > +	}
> 
> -- 
> With Best Regards,
> Andy Shevchenko
> 
>

Thanks,

Danny Kaehn

