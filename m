Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA7CD30B539
	for <linux-input@vger.kernel.org>; Thu, 19 Feb 2026 23:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771544422; cv=none; b=kb20KGV4pQz2tYfA6apqKs+sChJjy4x/XUN/70T1Bj1Y9D/OsP6jBY4i9XuYD89aWc8yzXGjTVUgC4A0IK5VDf/38LV9SEvMRVVfY1jLcxKdr7A1EgHUCewiUECIEKFzNi4yQAdlvsSm0FUJ0TXFgUKYnIvNfdOy+RDSiMJD/Dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771544422; c=relaxed/simple;
	bh=TRKFG9iyCZiU02kKGUXfEvPejwPiF+gGa7xpETSJMmg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aeZEmzHlA6uBsB/SshhIDda2YzdaKPugg6me3gxPpEdEZ+27gFriaJV1zkMZYz9QA40GvyJIVwp8iGRavU1QdeGfAZlBeli0d+zAPLrhUj/5JdkYbTL5K0a8tdJhGArPz7+uKWwIcW/0RcRFnfms7nFyvQZXCqcYiXmVoQ8oJsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=YMe9I95F; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="YMe9I95F"
Date: Thu, 19 Feb 2026 16:40:11 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1771544417;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IMYV8TJCxWvdL8j08krLV9Nx1g5eh+8pe7mOLnvSJDM=;
	b=YMe9I95FhYdbw5SzD0KPqIHn7JjFNWnaG7ReGJVQVUNvguA/iqmCYsvmtn2q3i4r0OnGFA
	/fxh6ass/0dI++GgE1A+3+Zw4nY0t0PSyTQbpiVOvPbkzyAXvaCa68zrejr5CAByqMXZX9
	OIBkDkZ6MvZbFvDo3+NqeWTN+o/I1Mc=
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
Message-ID: <s24u6ojnflb4nvpssgshjmgir77wpoos6qinypqac564fzcjyy@yilnrsy266er>
References: <20260111-v6-10-topic-touchscreen-axiom-v5-0-f94e0ae266cb@pengutronix.de>
 <20260111-v6-10-topic-touchscreen-axiom-v5-1-f94e0ae266cb@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260111-v6-10-topic-touchscreen-axiom-v5-1-f94e0ae266cb@pengutronix.de>
X-Migadu-Flow: FLOW_OUT

On Sun, Jan 11, 2026 at 04:05:44PM +0100, Marco Felsch wrote:
> Add FW_UPLOAD_ERR_DUPLICATE to allow drivers to inform the firmware_loader
> framework that the update is not required. This can be the case if the
> user provided firmware matches the current running firmware.
> 
> Sync lib/test_firmware.c accordingly.
> 
> Reviewed-by: Russ Weight <russ.weight@linux.dev>
> Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>
> Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
> ---
>  drivers/base/firmware_loader/sysfs_upload.c | 1 +
>  include/linux/firmware.h                    | 2 ++
>  lib/test_firmware.c                         | 1 +
>  3 files changed, 4 insertions(+)
> 
> diff --git a/drivers/base/firmware_loader/sysfs_upload.c b/drivers/base/firmware_loader/sysfs_upload.c
> index c3797b93c5f5a2ecf2ae34707893c89eb7773154..9e93070b2c24179986b868a24b09cf051776c644 100644
> --- a/drivers/base/firmware_loader/sysfs_upload.c
> +++ b/drivers/base/firmware_loader/sysfs_upload.c
> @@ -28,6 +28,7 @@ static const char * const fw_upload_err_str[] = {
>  	[FW_UPLOAD_ERR_RW_ERROR]     = "read-write-error",
>  	[FW_UPLOAD_ERR_WEAROUT]	     = "flash-wearout",
>  	[FW_UPLOAD_ERR_FW_INVALID]   = "firmware-invalid",
> +	[FW_UPLOAD_ERR_DUPLICATE]    = "firmware-duplicate",
>  };

Hi Marco,

There is a corresponding change that should be made to
lib/test_firmware.c. You can look at the recent change for
FW_UPLOAD_ERR_FW_INVALID as an example.

- Russ

>  
>  static const char *fw_upload_progress(struct device *dev,
> diff --git a/include/linux/firmware.h b/include/linux/firmware.h
> index aae1b85ffc10e20e9c3c9b6009d26b83efd8cb24..fe7797be4c08cd62cdad9617b8f70095d5e0af2f 100644
> --- a/include/linux/firmware.h
> +++ b/include/linux/firmware.h
> @@ -29,6 +29,7 @@ struct firmware {
>   * @FW_UPLOAD_ERR_RW_ERROR: read or write to HW failed, see kernel log
>   * @FW_UPLOAD_ERR_WEAROUT: FLASH device is approaching wear-out, wait & retry
>   * @FW_UPLOAD_ERR_FW_INVALID: invalid firmware file
> + * @FW_UPLOAD_ERR_DUPLICATE: firmware is already up to date (duplicate)
>   * @FW_UPLOAD_ERR_MAX: Maximum error code marker
>   */
>  enum fw_upload_err {
> @@ -41,6 +42,7 @@ enum fw_upload_err {
>  	FW_UPLOAD_ERR_RW_ERROR,
>  	FW_UPLOAD_ERR_WEAROUT,
>  	FW_UPLOAD_ERR_FW_INVALID,
> +	FW_UPLOAD_ERR_DUPLICATE,
>  	FW_UPLOAD_ERR_MAX
>  };
>  
> diff --git a/lib/test_firmware.c b/lib/test_firmware.c
> index be4f93124901e5faac41f48a66dabe6da56be0ca..952ec1cb03102911dbea9abd648ab9d9e0112a46 100644
> --- a/lib/test_firmware.c
> +++ b/lib/test_firmware.c
> @@ -1134,6 +1134,7 @@ static const char * const fw_upload_err_str[] = {
>  	[FW_UPLOAD_ERR_RW_ERROR]     = "read-write-error",
>  	[FW_UPLOAD_ERR_WEAROUT]	     = "flash-wearout",
>  	[FW_UPLOAD_ERR_FW_INVALID]   = "firmware-invalid",
> +	[FW_UPLOAD_ERR_DUPLICATE]    = "firmware-duplicate",
>  };
>  
>  static void upload_err_inject_error(struct test_firmware_upload *tst,
> 
> -- 
> 2.47.3
> 
