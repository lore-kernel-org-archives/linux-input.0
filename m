Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18E11344DB5
	for <linux-input@vger.kernel.org>; Wed,  5 Aug 2026 05:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785907396; cv=none; b=jkCG+9KW8P/NeXWmGueerA4ycpkjR2KDoNgbg3rlCDGW2VPatF4TVx71EPVCmOAwP/4tS0qmD7myuq0GlS1r8EiP911/yII+gGEkHumbsAdt9JCdqvw4jLYL8nG2HMhjDh59qOM8So3b3Hb57/KP+iArvVUUc8wl7sk09Q8NTMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785907396; c=relaxed/simple;
	bh=xRygjBeqtl3DM1YUyTSX+xTymVDkqZSb0c/0pboomaE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T9gLMW+ESyvaUYnC2EcEAkK2fA3SOScswoYIv6SxUxSBx7RaYMVgGTfIYB23d7/BAG9yT2umnLMriaAnp6jO1wGDqmNENnPHQRlsiI3xrSFQ0501lu/xOaFmN3KJW2DLvycCuQemgteoJdROHA2vCHATFseazT4E/lZAukWZYEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nFkiUTVL; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nFkiUTVL"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-8486ac3f347so1908635b3a.1
        for <linux-input@vger.kernel.org>; Tue, 04 Aug 2026 22:23:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785907394; x=1786512194; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=/HdM6bUtOuLf4vaeZ3R2Sq1G301/DGdLSrA83VIFE5Y=;
        b=nFkiUTVLWZ9IU5yrYOjelt+I7JE88TZUzHNZ8o7nkxU+1V/ejpAcy27Fx67HHZgP06
         yQUfFeU5MIYgFtl1hULTdEo9Z5Y5n2ofvXSKqh/s2CjRL6lZ1cFw6zx2Hrdk9lZLuBm4
         lk1KWMSzB2yb9jmg6MD9xgd91gEykk2CAFhr9bLOzUzkEjwbm6VCUJdpLDgkq44Hkaa8
         fQrxzlJ50iFr0RJxvozuTH9M5mQWgRP2Qb91nhSWDBsFait6gXHBBRj2RpxHj4iL6xVn
         Fnz9HK82iaOEvxXVgk0WmlnCPfoh/xEARFBZNNt6vbwvDV8nNXatAWvqZTcqOmWUjejR
         N4ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785907394; x=1786512194;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/HdM6bUtOuLf4vaeZ3R2Sq1G301/DGdLSrA83VIFE5Y=;
        b=dzURAJ18NEYYEl1BiLMrN2bQVly3aV1dlDsmCYsS4QjiKL9qfs1h/Mqi+GOnIueMAn
         gl0+nU/2QpnC8XlQghlhXt4bbvELqUfNmsMhv75luRaaJ2sgcXeoSM/QzwTsQoWEr27t
         ldWvKTteH1CDE93+3Xk24oKS6qZhlfEN6/Ndn7PeMBz83cu3lcDwMWz9I57X/j/Zkglm
         +o/643DmAjYOCPqBjxVMxsaYdVISgnfdo5/JGJBcAvuBLXXQEYy6PYXM8YjDqiF0KGKC
         JH6Md/5ajbbk2+tL6+O/GmFGE+ZP15luhWOlYVkv/zQXV2qMU1Z9Efv2b/afcO7NR+VA
         +ZNA==
X-Gm-Message-State: AOJu0YyTj0DhzeX7zFeUwHO8EYx0HtOstw3MBAmZv9WRh0F5DydnL912
	0gcFd1LMbLYlnyyp7dqjoZCKK9yzmIF42pghXHJrE615o8VfRMODl55Q
X-Gm-Gg: AR+sD129TLYJw61CnwYnPsrKlkTb4sap3nY3m450lnH/ztmz4ALFgDbXnzIpgeCMBzP
	bxcidxtD92x0rgJ46/bIDs5caS1dZwRucgYLqS8/ae173mtaejWnne3Hu0nd7CYP5YPHqSO+nPP
	gtnjCdlB5DYJQ3jOmy0j7zHiJmxyCHfKBZrtpM/iLiAVw4PtvDIXo8qxo4fDfm3bKmFgme39RGU
	0KGdxU1MHdmQDQkOmDU05WLbqpMto4DyqC+/x6ZuUDW0Ca6+8X8nzZXwUbbACyreBONm6IXAJb3
	oKne14lScy3g+pEhbmC6oDDPHhC9an4+ekNURUL5Qfd61lL/85DDppR2Eh0TgxKPsEVuVtzbrng
	apbt670/ioZmQgDw24JRWuMtGgsLp8xREvpRukbfY9UtgbyJChMnkPcqqWHJ9YFqngWXkf5UtkT
	gl5pyYx8mkQWpgrhLs4OOvWW7H6ow6WXWQ00SCGoepttCHUWX/WH1jqD0zJDcBvTWPBy5djrwDe
	kz7dwa/HifwXQLIDmOPuX8cs6d9mw==
X-Received: by 2002:a05:6a20:a11b:b0:3b3:a66e:3911 with SMTP id adf61e73a8af0-3cb6c9c179dmr9314476637.19.1785907394406;
        Tue, 04 Aug 2026 22:23:14 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:bf3a:ac93:79c4:84fd])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3158673be99sm20448477eec.15.2026.08.04.22.23.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2026 22:23:13 -0700 (PDT)
Date: Tue, 4 Aug 2026 22:23:11 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: sashiko-reviews@lists.linux.dev
Cc: linux-input@vger.kernel.org
Subject: Re: [PATCH] Input: rmi_smbus - fix out-of-bounds read in
 rmi_smb_write_block()
Message-ID: <anLImeKU7fGoyRQz@google.com>
References: <anLFSMKSoKyyZ272@google.com>
 <20260805052039.C1CA21F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260805052039.C1CA21F000E9@smtp.kernel.org>

On Wed, Aug 05, 2026 at 05:20:39AM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> 
> Pre-existing issues:
> - [High] Pre-existing stack/heap buffer overflow in `rmi_smb_read_block()` due to unsafe use of `i2c_smbus_read_block_data()` without a bounce buffer.
> --
> 
> --- Patch [1]: [PATCH] Input: rmi_smbus - fix out-of-bounds read in rmi_smb_write_block() ---
> commit 530e4667b6144c7e030412bbc818f1de86a5a09e
> Author: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> 
> Input: rmi_smbus - fix out-of-bounds read in rmi_smb_write_block()
> 
> This commit fixes an out-of-bounds read in rmi_smb_write_block() by ensuring
> block_len is calculated using the remaining length (cur_len) rather than the
> original total length.
> 
> > diff --git a/drivers/input/rmi4/rmi_smbus.c b/drivers/input/rmi4/rmi_smbus.c
> > --- a/drivers/input/rmi4/rmi_smbus.c
> > +++ b/drivers/input/rmi4/rmi_smbus.c
> [ ... ]
> > @@ -148,7 +148,7 @@ static int rmi_smb_write_block(struct rmi_transport_dev *xport, u16 rmiaddr,
> >  		/*
> >  		 * break into 32 bytes chunks to write get command code
> >  		 */
> > -		int block_len = min_t(int, len, SMB_MAX_COUNT);
> > +		int block_len = min_t(size_t, cur_len, SMB_MAX_COUNT);
> >  
> >  		retval = rmi_smb_get_command_code(xport, rmiaddr, block_len,
> >  						  false, &commandcode);
> [ ... ]
> 
> [Severity: High]
> This is a pre-existing issue, but since the chunking logic in 
> rmi_smb_write_block() is being corrected here, does a similar buffer overflow 
> exist in the read path?
> 
> Looking at smb_block_read(), it ignores the len argument and passes the 
> buffer directly to i2c_smbus_read_block_data():
> 
> drivers/input/rmi4/rmi_smbus.c:smb_block_read() {
>     ...
>     retval = i2c_smbus_read_block_data(client, commandcode, buf);
>     ...
> }
> 
> If a caller requests a small read, or if the final partial chunk in 
> rmi_smb_read_block() has less than 32 bytes of capacity remaining:
> 
> drivers/input/rmi4/rmi_smbus.c:rmi_smb_read_block() {
>     ...
>     retval = smb_block_read(xport, commandcode, databuff, block_len);
>     ...
> }
> 
> Could a malfunctioning I2C device returning a length greater than block_len 
> cause the I2C core to unconditionally copy up to 32 bytes, overflowing 
> the databuff allocation?
> 

Yes, but I hope this can be addressed once improved version of 
i2c_smbus_read_block_data() lands.

Thanks.

-- 
Dmitry
