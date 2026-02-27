Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71F7247AF40
	for <linux-input@vger.kernel.org>; Fri, 27 Feb 2026 22:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772229932; cv=none; b=paLmr6LNvAKMgBcUQOa/wuvaho2rZgQZzPqz1qgkUZjO/zT2Nom3wBPFNlEIGFEMO7FRrHGmbnlnYnhHNyKgrWjrLrpgr0ZqhOLrgM8G8WXzjFsFSVaE1HYbgBbyG5gPsCTB/JbXizDu+3fhxGfTemgLtnk8MP4G5Faorhzfujk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772229932; c=relaxed/simple;
	bh=I2+/CauqTdPKwPQVJ0n1qP6TsrR2qijPOlq2MinwQ3g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DSW3eurm+3zOz1AxLoMRa31NV/9fhqQLsTmeL5OjUKxXI1mfi+B3gkDjx+JAoAVHP9CfwlR4Ce+cx2sSjIoG+h59/59aRpcMVfOZ9XsqnMEPBEia1pZ65Zq8/rXQxFOfRC5m8uDGahS9ByLEvmICmvf7qGTqCfPvtCNq3KDNjQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=wEPd05/i; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="wEPd05/i"
Date: Fri, 27 Feb 2026 15:05:03 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1772229916;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pnFl0/AYbq6JvLPKWpr7Jr/uWHcZ5P72Xj8c/j2ZcHQ=;
	b=wEPd05/i1jVU9Tot4uyyDaeJFQib1QkA9YFMYNZ+1Qg7UrJea1gEORnGQBe4wP2MQHePng
	ZhwLHqzfaHSxhGnIMCTF4lhsVoVGCkRkOC/ssHrik3sIZqS+hbmdnUO5zyGbIS5Csz9K4h
	wphMaNLiKVPFOpGIgGt/tBA/1XAN7eI=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Russ Weight <russ.weight@linux.dev>
To: Marco Felsch <m.felsch@pengutronix.de>
Cc: Luis Chamberlain <mcgrof@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, Kamel Bouhara <kamel.bouhara@bootlin.com>, 
	Marco Felsch <kernel@pengutronix.de>, Henrik Rydberg <rydberg@bitmath.org>, 
	Danilo Krummrich <dakr@kernel.org>, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-input@vger.kernel.org
Subject: Re: [PATCH v5 1/4] firmware_loader: expand firmware error codes with
 up-to-date error
Message-ID: <do22h6yblkb4ni25epccmuaw74aefh4f252ffgleoat7hxgkur@lmrnsjikbg6w>
References: <20260111-v6-10-topic-touchscreen-axiom-v5-0-f94e0ae266cb@pengutronix.de>
 <20260111-v6-10-topic-touchscreen-axiom-v5-1-f94e0ae266cb@pengutronix.de>
 <s24u6ojnflb4nvpssgshjmgir77wpoos6qinypqac564fzcjyy@yilnrsy266er>
 <3ohould4vufzfqau4e7vg2ztks3gflmfosyaizggwzufbwvx2f@yqsgim7ash3x>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3ohould4vufzfqau4e7vg2ztks3gflmfosyaizggwzufbwvx2f@yqsgim7ash3x>
X-Migadu-Flow: FLOW_OUT

On Mon, Feb 23, 2026 at 11:39:02AM +0100, Marco Felsch wrote:
> Hi Russ,
> 
> On 26-02-19, Russ Weight wrote:
> > On Sun, Jan 11, 2026 at 04:05:44PM +0100, Marco Felsch wrote:
> > > Add FW_UPLOAD_ERR_DUPLICATE to allow drivers to inform the firmware_loader
> > > framework that the update is not required. This can be the case if the
> > > user provided firmware matches the current running firmware.
> > > 
> > > Sync lib/test_firmware.c accordingly.
> > > 
> > > Reviewed-by: Russ Weight <russ.weight@linux.dev>
> > > Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>
> > > Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
> > > ---
> > >  drivers/base/firmware_loader/sysfs_upload.c | 1 +
> > >  include/linux/firmware.h                    | 2 ++
> > >  lib/test_firmware.c                         | 1 +
> > >  3 files changed, 4 insertions(+)
> > > 
> > > diff --git a/drivers/base/firmware_loader/sysfs_upload.c b/drivers/base/firmware_loader/sysfs_upload.c
> > > index c3797b93c5f5a2ecf2ae34707893c89eb7773154..9e93070b2c24179986b868a24b09cf051776c644 100644
> > > --- a/drivers/base/firmware_loader/sysfs_upload.c
> > > +++ b/drivers/base/firmware_loader/sysfs_upload.c
> > > @@ -28,6 +28,7 @@ static const char * const fw_upload_err_str[] = {
> > >  	[FW_UPLOAD_ERR_RW_ERROR]     = "read-write-error",
> > >  	[FW_UPLOAD_ERR_WEAROUT]	     = "flash-wearout",
> > >  	[FW_UPLOAD_ERR_FW_INVALID]   = "firmware-invalid",
> > > +	[FW_UPLOAD_ERR_DUPLICATE]    = "firmware-duplicate",
> > >  };
> > 
> > Hi Marco,
> > 
> > There is a corresponding change that should be made to
> > lib/test_firmware.c. You can look at the recent change for
> > FW_UPLOAD_ERR_FW_INVALID as an example.
> 
> Can you elaborate a bit more please? I've added the
> FW_UPLOAD_ERR_DUPLICATE to lib/test_firmware.c with this patchset and I
> don't know what you want me todo.

Hi Marco,

Please disregard. I didn't remember that test_firmware.c was updated
in the same patch as sysfs_upload.c. It looks good as is.

- Russ

> 
> Regards,
>   Marco
> 
> 
> > 
> > - Russ
> > 
> > >  
> > >  static const char *fw_upload_progress(struct device *dev,
> > > diff --git a/include/linux/firmware.h b/include/linux/firmware.h
> > > index aae1b85ffc10e20e9c3c9b6009d26b83efd8cb24..fe7797be4c08cd62cdad9617b8f70095d5e0af2f 100644
> > > --- a/include/linux/firmware.h
> > > +++ b/include/linux/firmware.h
> > > @@ -29,6 +29,7 @@ struct firmware {
> > >   * @FW_UPLOAD_ERR_RW_ERROR: read or write to HW failed, see kernel log
> > >   * @FW_UPLOAD_ERR_WEAROUT: FLASH device is approaching wear-out, wait & retry
> > >   * @FW_UPLOAD_ERR_FW_INVALID: invalid firmware file
> > > + * @FW_UPLOAD_ERR_DUPLICATE: firmware is already up to date (duplicate)
> > >   * @FW_UPLOAD_ERR_MAX: Maximum error code marker
> > >   */
> > >  enum fw_upload_err {
> > > @@ -41,6 +42,7 @@ enum fw_upload_err {
> > >  	FW_UPLOAD_ERR_RW_ERROR,
> > >  	FW_UPLOAD_ERR_WEAROUT,
> > >  	FW_UPLOAD_ERR_FW_INVALID,
> > > +	FW_UPLOAD_ERR_DUPLICATE,
> > >  	FW_UPLOAD_ERR_MAX
> > >  };
> > >  
> > > diff --git a/lib/test_firmware.c b/lib/test_firmware.c
> > > index be4f93124901e5faac41f48a66dabe6da56be0ca..952ec1cb03102911dbea9abd648ab9d9e0112a46 100644
> > > --- a/lib/test_firmware.c
> > > +++ b/lib/test_firmware.c
> > > @@ -1134,6 +1134,7 @@ static const char * const fw_upload_err_str[] = {
> > >  	[FW_UPLOAD_ERR_RW_ERROR]     = "read-write-error",
> > >  	[FW_UPLOAD_ERR_WEAROUT]	     = "flash-wearout",
> > >  	[FW_UPLOAD_ERR_FW_INVALID]   = "firmware-invalid",
> > > +	[FW_UPLOAD_ERR_DUPLICATE]    = "firmware-duplicate",
> > >  };
> > >  
> > >  static void upload_err_inject_error(struct test_firmware_upload *tst,
> > > 
> > > -- 
> > > 2.47.3
> > > 
> > 
> 
> -- 
> #gernperDu 
> #CallMeByMyFirstName
> 
> Pengutronix e.K.                           |                             |
> Steuerwalder Str. 21                       | https://www.pengutronix.de/ |
> 31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
> Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-9    |
