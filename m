Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF1C62DB7B8
	for <linux-input@vger.kernel.org>; Sat, 13 Jun 2026 16:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781367598; cv=none; b=pSCr9n0gSnN3Qb4uN6tDkDAksLuHQPex+P4wgm3/6/YGCUr0TV401k6mZ4JKGcwZ0pV92igX+SDB1iw2u4B8cxXKRioW6/JoHXmITTkqbZ5g4W31VZ3uNw+qsv12g7sWV6WSJ2CtkpGk3SW/dmXaLizoVyvO0agaUmhqt5ivzJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781367598; c=relaxed/simple;
	bh=oj73ZV9S9kFFAVkngir0JIq9ezt/lhN6IfDYE71zuuE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g/KnjHbNtrqY4O492qJyiVucA4mAsEhcGmhkGERTcNJ5vmC+OVUhAuQ8jyATGxZH2/n1ke8vXFezwgVg+lU3OlUNt9fh6ZtbAq/zeaoGnXa3k79cgRTTlzuegxm/qsEl3cJ7SUFZAnN2ubzRckSH3IT/QSalJvbdDRCZnVkEAOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UoybSsDn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UoybSsDn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79A0E1F000E9;
	Sat, 13 Jun 2026 16:19:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781367597;
	bh=Akl7aG3JCuwQobMNt/pesFu1W1qvWaKo+ooxTU3O4Lk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=UoybSsDnzbEyIgCP1ymQ6vXBn/9MDVtMlA6qY2+s29pUVcwVtPDzSWpzoS0ibMuC2
	 gk6+o3jwrIF+l4zY5HogSWZ6t/96lfxY7jMOSnImdwNWJQsFzgOgdmymQ2IV7r+J2Z
	 W/1PFMEBYvxCMk3yXKEWjUjpDxtO7ar9q5yI/SXurTc7D6d+QvtABHIY2n27BR6F9K
	 bPJggZCpChvq2/KUhH0YdrsbIEDq111fnJ+PjhgLjRwft3OpBdHnGUtPG8tx+AMdn7
	 +BlUzQt7cJmsFBWwwNv2LyMJlDXp6pou7D/reWfClVWHyQPIX6ZK+PJkfDlnAuzvUH
	 UZcNcnn9uZ0Eg==
Date: Sat, 13 Jun 2026 12:19:53 -0400
From: Nathan Chancellor <nathan@kernel.org>
To: Paolo Pisati <p.pisati@gmail.com>
Cc: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>,
	linux-input@vger.kernel.org
Subject: Re: [PATCH 1/7] hid-asus: Fix up Zenbook Duo report descriptors
Message-ID: <20260613161953.GA2700668@ax162>
References: <20260513163248.16483-1-p.pisati@gmail.com>
 <20260513163248.16483-2-p.pisati@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260513163248.16483-2-p.pisati@gmail.com>

Hi Paolo,

On Wed, May 13, 2026 at 06:32:42PM +0200, Paolo Pisati wrote:
> From: Joshua Leivenzon <hacker1024@users.sourceforge.net>
> 
> This is similar to the T100CHI/T90CHI keyboard dock fix.
> Without it, all reports log:
> 
> Unmapped Asus vendor usagepage code 0x76
> 
> Signed-off-by: Joshua Leivenzon <hacker1024@users.sourceforge.net>
> ---
>  drivers/hid/hid-asus.c | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
> index 3f5e96900b67a..ce246efba74d3 100644
> --- a/drivers/hid/hid-asus.c
> +++ b/drivers/hid/hid-asus.c
> @@ -99,6 +99,7 @@ MODULE_DESCRIPTION("Asus HID Keyboard and TouchPad");
>  #define QUIRK_ROG_CLAYMORE_II_KEYBOARD	BIT(12)
>  #define QUIRK_ROG_ALLY_XPAD		BIT(13)
>  #define QUIRK_HID_FN_LOCK		BIT(14)
> +#define QUIRK_ZENBOOK_DUO_KEYBOARD	BIT(15)
>  
>  #define I2C_KEYBOARD_QUIRKS			(QUIRK_FIX_NOTEBOOK_REPORT | \
>  						 QUIRK_NO_INIT_REPORTS | \
> @@ -1384,17 +1385,20 @@ static const __u8 *asus_report_fixup(struct hid_device *hdev, __u8 *rdesc,
>  		hid_info(hdev, "Fixing up Asus T100 keyb report descriptor\n");
>  		rdesc[74] &= ~HID_MAIN_ITEM_CONSTANT;
>  	}
> -	/* For the T100CHI/T90CHI keyboard dock */
> -	if (drvdata->quirks & (QUIRK_T100CHI | QUIRK_T90CHI)) {
> +	/* For the T100CHI/T90CHI keyboard dock and Zenbook Duo 2024+ keyboards */
> +	if (drvdata->quirks & (QUIRK_T100CHI | QUIRK_T90CHI | QUIRK_ZENBOOK_DUO_KEYBOARD)) {
>  		int rsize_orig;
>  		int offs;
>  
>  		if (drvdata->quirks & QUIRK_T100CHI) {
>  			rsize_orig = 403;
>  			offs = 388;
> -		} else {
> +		} else if (drvdata->quirks & QUIRK_T90CHI) {
>  			rsize_orig = 306;
>  			offs = 291;
> +		} else if (drvdata->quirks & QUIRK_ZENBOOK_DUO_KEYBOARD) {
> +			rsize_orig = 257;
> +			offs = 176;
>  		}

The way this if block is now written will cause a clang warning:

  https://lore.kernel.org/202606110526.QfgiXQTQ-lkp@intel.com/

It is obviously a false positive since we know one of those branches
will be taken from the parent if statement's condition.

Consider keeping the else, maybe with a comment, to make it clear to
both humans and the compiler that all cases are covered?

  } else { /* QUIRK_ZENBOOK_DUO_KEYBOARD */
    rsize_orig = 257;
    offs = 176;
  }

>  		/*
> @@ -1414,7 +1418,8 @@ static const __u8 *asus_report_fixup(struct hid_device *hdev, __u8 *rdesc,
>  
>  			hid_info(hdev, "Fixing up %s keyb report descriptor\n",
>  				drvdata->quirks & QUIRK_T100CHI ?
> -				"T100CHI" : "T90CHI");
> +				"T100CHI" : drvdata->quirks & QUIRK_T90CHI ?
> +				"T90CHI" : "ZENBOOK DUO");
>  
>  			memcpy(new_rdesc, rdesc, rsize_orig);
>  			*rsize = rsize_orig + 1;
> -- 
> 2.53.0
> 

-- 
Cheers,
Nathan
