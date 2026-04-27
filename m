Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4964D2E11D2
	for <linux-input@vger.kernel.org>; Mon, 27 Apr 2026 04:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777262447; cv=none; b=D1gV6DbzkY3GxLPaq3zzeZFdPESmf9ek+GgJjqGvisLvHftC4ZpBNgZgX6nPGDd+uo5Ew/ymEk/k7CU50tgDkgAFPhUSZmFi06jI74KCCRUTj56r3DvEM+QoKJaNF2xr7veti0cSDIdAsB6BPZSmFZG1mnS5vEjTOxshDSizcwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777262447; c=relaxed/simple;
	bh=t9yj5Qg2FxTNuaJOAUuuBZBNt9dwTcJQjX+hGnV8qlg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CJb2OAJpyX05oxrjNqbCoPd3W+W19C/EOQU9E1WjViQB8Tb401D9goZD6Jft5pGf2TbZNQiT2BzGUQho5968E5hhPu5DNhok/1j2oliSlRwO2VQFT8dW9lSj1AV/sRIflELN386wqqAPE+I/OD2MQD2mjn1ab1D/rBd4yXWCEU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eOceEJNF; arc=none smtp.client-ip=74.125.82.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eOceEJNF"
Received: by mail-dl1-f46.google.com with SMTP id a92af1059eb24-12c8ccc7755so9647330c88.0
        for <linux-input@vger.kernel.org>; Sun, 26 Apr 2026 21:00:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777262445; x=1777867245; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=CGQCL7SrsaS5fR3zoA5TJTuoz5gskrQFWO/okRWQKcg=;
        b=eOceEJNFAy86nuX+kCwZU5W6t4l8q6JPhNGEW7nrTr1uJ4Olw1QaPP7A8mvuehTP9B
         9nep+a9U84BZB70WbEGGbTJHGdFajkwmJwbAqhAHynE1AyVN9a3aceNtrnW7oN/QFfjO
         MTLevmCF0X8uj+SRVKR9gf0+AH+w4a6qUryxB1ZpNNogRom8Qo23sC1l8dgJeViWjTuH
         Dy2G3O43KxdmpvfneP9HqU8EeKPURfjUqJVIZIhkh8poBpIDIxCYXdRBB2A75+2BCoIK
         10Gvu70Ng6YvuDmEmTJFWTYElDVpyi64BrxunrQPiSZLp1HcjMP7cxjSOYOlyl5x2qlW
         iLOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777262445; x=1777867245;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CGQCL7SrsaS5fR3zoA5TJTuoz5gskrQFWO/okRWQKcg=;
        b=oweaWSQucEJUbSxfTrr82Bu41z++PC+nTkRoAgnZLLgRbTW+lAji/07EcqzvnhYnNQ
         eVJhjNUX5V1DC6tpKlBmmrfpUwHBSVMY6TKrPe0AzJlX6vZvso5zx+Cd0OjyXWKJdk3L
         /2yIbjtWQUlPglNr3zXa4Qo9Sf/01rzNkMI3wCKAUypGA37kSNyK6tFN78CSU7r43NkK
         YLKtLduQdziMDHwF7+0QjWAy+IyNJOUPYwZ+TPBBM3DZKBYc6tlKDS+TJJG1T3d3PIgx
         jB9zzST6nTY8YH71w2SnAH8CGragld6OaXjjmsRWLRu1rNl+2WGs+xWTubaxTK+vz4r3
         N0Lw==
X-Gm-Message-State: AOJu0YzEGvwINAXFFXafI53E8rLMFBxSPExQvj8pON5b/hhSp2VFexXE
	W+uIONpl177oHpDBZ1fZqqQnGKNoneywMXMR9x5LwjQr2YFizhCa6su/
X-Gm-Gg: AeBDiesU0Hy2Q/wpSSrlZOB7OY8t0ITSfrAmPTD86wmnQ6eYn9Y0x2fyIBB11NtvqSF
	pQETbOsvWqrQyp0JM5EuIMpSmddFfuiOzZ0rGTsKvuyXZoIhtv6shd1A8eoXgE6/TB+1iPnrvUQ
	/boZ+X0syADTXiqXG84mod8iWWJjDErrg5MnS66c9JJ6MKeTFoOXoX784U/nQDHSDN2mKSevTXS
	Gl4nTJwjvcKrl8smMJyPfYfIBeUNVx48OCvw5bgwhqs68l2pNNya70JSWR48jzkUv42+i7uKK0o
	2oOS7IlLISGy8S52n5fXhhiMfY7Pf8g6z+NQL/o9IOl3X3a025CLOSwPQCxT2q0OEcrRQH8fEOv
	Sok6r8Ab6mek+d0U10+8mj2lWzglqJnN/3bfIOKdOgFOnEF0Pl2F/XBHxKh7nYkSO0thOjo+A/Y
	4/LrtAZdLX2TLfDCj6eQfg0KW4Stk64T9VHpUxvD/uwMUmAkOHIxgTIKSnlg045hvjIQZpSvfuy
	g==
X-Received: by 2002:a05:7022:6884:b0:12c:6e75:bb1 with SMTP id a92af1059eb24-12c73f64455mr20494687c88.4.1777262445010;
        Sun, 26 Apr 2026 21:00:45 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:da2b:741f:93fe:403])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12c74a18a2bsm64909899c88.10.2026.04.26.21.00.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Apr 2026 21:00:44 -0700 (PDT)
Date: Sun, 26 Apr 2026 21:00:41 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable <stable@kernel.org>
Subject: Re: [PATCH] Input: usbtouchscreen - clamp NEXIO data_len/x_len to
 URB buffer size
Message-ID: <ae7fXWVgR7oYfrUC@google.com>
References: <2026042026-chlorine-epidermis-fd6d@gregkh>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2026042026-chlorine-epidermis-fd6d@gregkh>

On Mon, Apr 20, 2026 at 06:00:27PM +0200, Greg Kroah-Hartman wrote:
> nexio_read_data() pulls data_len and x_len from a packed __be16 header
> in the device's interrupt packet and then walks packet->data[0..x_len)
> and packet->data[x_len..data_len) comparing each byte against a
> threshold.
> 
> Both fields are 16-bit on the wire (max 65535).  The existing
> adjustments shave at most 0x100 / 0x80 off, so the loop bound can still
> reach roughly 0xfeff.  The URB transfer buffer for NEXIO is rept_size
> (1024) bytes from usb_alloc_coherent(), with the first 7 occupied by the
> packed header — so packet->data[] has 1017 valid bytes.  read_data()
> callbacks are not given urb->actual_length, and nothing else bounds the
> walk.
> 
> A device that lies about its length can get a ~64 KiB out-of-bounds read
> past the coherent DMA allocation.  The first index whose byte exceeds
> NEXIO_THRESHOLD lands in begin_x / begin_y and from there into the
> reported touch coordinates, so adjacent kernel memory contents leak to
> userspace as ABS_X / ABS_Y events.  Far enough out, the read can also
> hit an unmapped page and fault.
> 
> Fix this all by clamping data_len to the buffer's data[] capacity and
> x_len to data_len.
> 
> Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> Fixes: 5197424cdccc ("Input: usbtouchscreen - add NEXIO (or iNexio) support")
> Cc: stable <stable@kernel.org>
> Assisted-by: gkh_clanker_t1000
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Applied, thank you.

-- 
Dmitry
