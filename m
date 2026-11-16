Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.10
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794839106;
	b=ZW7XQMYyw0MqTEKKDGrrIbZUFVzBzHfkWaJQ5oPWsWSy1vyWRGFg0xL8eH9xovye/bBG
	 iZTz5JK4AE1s3aj6jFdTh3kHmGgcKWzOgekQRpTr2wy0bJP0dB4UX+zNxwonjnhzA4cnZ
	 RIA0IOOYb0uREsXCmWSGX0CF6RFXUuXbwpp7w9OYDxzhh7313KpE61Q+NffwTzvg+m+OL
	 y49cbnQMQJBae+YAhW/WZLIXRrNhjP7xFPLMYW2Vd4dFA5X6nQGsc+YAzRwOb9o/EpjRL
	 0qlDND12xEJcW8CpJ8wbJEobeGNP5LiodUOt8NJmF2mgLn/Pwpu/uZ02reKgDo+y5JA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794839106;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=HnO5XJEfN483URHhDsMTcKxnpD/lEf/3G0We28AZ8io=;
	b=QYI6buOyC7bL+noNIFo6m7QQvJwAN7Vp98g0/jQT9OkNWe0zr+IDwa8ngAcS7BHeasjY
	 MQb+SZOJAuK2yqmi9PQjk7y6PZt2NKBdR7Mye76hKOSxrx2t00RF2ImUlLPJsx4fY00d8
	 O00z3hwhe25lAsG6OIHkohq1lSpCNq77WQ8ONFECBAJ4+9x25KDssf+2N9iz8t8M7SPTi
	 A1OWvRpfdUPAe3iTxGWtLaUn0c5rTUfji2j+nKYNH+jUaGQ3kK0TStQguUn+j0BcCrqPA
	 kop34JDZqQX6ln7LYxinrK2FEbuiyyj9IoXrEj9zeSZTfdLnTmBWBz2cvlOLASQR79g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b="iN/bqpfz";
	arc=none smtp.remote-ip=198.175.65.10
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14CDA606A31C;
	Mon, 16 Nov 2026 14:25:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 14CDA606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=iN/bqpfz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794839106; x=1826375106;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=5XYVZzolNEeWnuwpUSwZI6Jbl8VfAdO3jH26YaDBaHQ=;
  b=iN/bqpfztjrc7WSCOfbDxPzeGA4c9wYXZErUNvHUQXC8WZISvFRaMUcd
   CnQmDwYSJjEQBXCeBUT52um07QTSK+mZwNQIR6pOqG7o6406o05xCrP0d
   1FUD/AHdau5L8xdfmUzYF2tJNX0o2XXMmTpO+E6pR2bFfTJRQ6dF0bcY3
   VlWRbLeKoW+SUBc5oaxvN1ZlBF6aZqOXNaEdiSbzi1rykNnXzgkQegan/
   eb4X6yxcOcDFE1t475N0Xn201deLW881Q4sxgwYTQQRd1oxjbYYwouSr1
   MCp3L79SKdRCW2sAxQSz5GcCJVNqEI3r4UJNooyfuvGjJpBIe8eIE5oSU
   Q==;
X-CSE-ConnectionGUID: 7xVIVqEmQAexnRvwVcNKSA==
X-CSE-MsgGUID: Ga/hhJwKTmq/sge8/MZvIQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11968"; a="3485135"
X-IronPort-AV: E=Sophos;i="6.27,216,1787036400"; 
   d="scan'208";a="3485135"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2026 06:25:05 -0800
X-CSE-ConnectionGUID: KO1pWhADQQG8H6jAfvyTdQ==
X-CSE-MsgGUID: 8lxZYHAKQseLAZDSaceb8w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,216,1787036400"; 
   d="scan'208";a="9484100"
Received: from smoticic-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.90])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2026 06:25:03 -0800
Date: Mon, 16 Nov 2026 16:25:00 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: A Kishki <alaa6394@gmail.com>,
	Nirujogi Pratap <pratap.nirujogi@amd.com>, Bin Du <bin.du@amd.com>
Cc: testyiprywatnosc@gmail.com, benjamin.tissoires@redhat.com,
	jikos@kernel.org, linux-input@vger.kernel.org,
	lovekeshsolanki00@gmail.com, linux-i2c@vger.kernel.org,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: Re: [BUG] HID: i2c-hid: ELAN 04F3:30FD touchpad reset race causes
 -EREMOTEIO on HP Pavilion Gaming 15-ec1xxx
Message-ID: <avsSPIIx4pM8zsj8@ashevche-desk.local>
References: <CAO6oLZEsN5gkaDvS97i_7bgPFOE-5eX8WjmGcWCcYHvTMQm9Kw@mail.gmail.com>
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAO6oLZEsN5gkaDvS97i_7bgPFOE-5eX8WjmGcWCcYHvTMQm9Kw@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Nov 16, 2026 at 01:54:34PM +0100, A Kishki wrote:
> 
> I found the cause on the same laptop. It is the SDA hold time of the
> touchpad's I2C controller, not a reset race in i2c-hid.
> 
> Machine: HP Pavilion Gaming Laptop 15-ec1xxx, board 87B1, BIOS F.25
> (08/18/2021), Ubuntu kernel 7.0.0-43-generic.
> 
> IC_SDA_HOLD of AMDI0010:03 (0xfedc5000 + 0x7c):
> 
>   normal boot, touchpad dead:         0x00010001
>   boot via HP startup menu, works:    0x00010048
> 
> The ACPI tables give no hold time for this controller, so
> i2c_dw_set_sda_hold() keeps the value it finds ("Keep previous hold
> time setting if no one set it"). After a normal boot that is the reset
> value, a TX hold of one clock, so the touchpad NACKs its address. The
> startup-menu path leaves 0x48, which is why the F9 and UEFI-setup
> workarounds help, and probably why the live ISOs worked, if they were
> booted from the F9 menu.
> 
> To confirm, in a failed boot I unbound AMDI0010:03 from i2c_designware,
> wrote 0x00010048 to the register through /dev/mem and bound it again.
> The touchpad probed at once and works with hid-multitouch. A rebind
> without the write changes nothing, because the driver reads the same
> value back.
> 
> I run this as a boot-time workaround:
> https://github.com/AhmedKishki/hp-pavilion-15-ec1-touchpad-fix
> 
> A real fix probably belongs in i2c-designware, for example a DMI quirk
> that sets the hold time for this model. I'm happy to test patches.

I think you can ask AMD people to help with the patch cooking.
I Cc'ed maintainers of AMDISP, hopefully they help, or at least lead
you to one who may help.

-- 
With Best Regards,
Andy Shevchenko


