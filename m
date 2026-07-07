Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38FB23783A0
	for <linux-input@vger.kernel.org>; Tue,  7 Jul 2026 02:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783392986; cv=none; b=aijAz/DNT1YH+G8ynJGfZOKYOKeqqR44R4vRbZPEruiACmgpp9CSQYvRAKogIDjAzZxPdgUmSwaTqe1LOV9BzCOrt6rmjZgPIvAej60eM1dm7l9+FrBvtms52tTgdVQRNvuVDu5dpPx9By46K8p0Iuep/U1deCqPgwJ4anRudyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783392986; c=relaxed/simple;
	bh=1ntjpdeE611zYVcjCs+zlHBG1IOa9o9IqXXK4fqQJSc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NqeQXZ423OQp2u5ZvldFpUwKuZEGv3bbyMe4uPZpjAdNs4K3b6SdQNS8JpZr5G3TNzPZWuT3TTz8y66qcinJWoAOmRT+BHGrAAC/sVvi7s7k2q7zY4EDe+og+VVrVgPustKTXJsLKGg1CnLaxV6Xw1oEb8J0UmEEsbpcxjN1iEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gl9E67iQ; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gl9E67iQ"
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-c9aaa90a791so2889083a12.3
        for <linux-input@vger.kernel.org>; Mon, 06 Jul 2026 19:56:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783392984; x=1783997784; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=E6I//5r/eycvzAzyJWx3BIqreiNVij0IJXy7AW5vJwM=;
        b=gl9E67iQmzugxCQpjxfmwd+6tpMXoJ4hTcgsgvkqRZpy2DgMujdAGFgh9n2uxJeQ3x
         Oyb2t1jN6Q5C4QKcWmq6JdIq6IbT3Wn5EXCsJI4HJOSsulaSUnaU/aePCXk/v0iXJYx9
         BbrRzT+6zR22DJbk+AfnjtqLMCyzjD4gRNBrnDUNBFoOPfc4agGSvmQ7JDxw1dy1wGWU
         Xyj7Geu8Hus6/7Bv4BMvRo8K8HBivH3voC13X3BF/yQfsqFSKK0UYC/Z/AkOOJtc4g9+
         VuqJYVG9HX1f1fA9bLkEYFrKVOVhtRpitKs2NC2cUnW6HH1tNdrj4yoyemGcCSvuMGJt
         vz+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783392984; x=1783997784;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E6I//5r/eycvzAzyJWx3BIqreiNVij0IJXy7AW5vJwM=;
        b=kC15NsCge5d0NhfymHTs8BaO4/5LfflzSTGCYgxFl4eph0OhYKWlWQ5FgGy68dOTMh
         l2mjvCniTfwxo5m2CxWQ6Hx13zrJd5udMegw1BuVJr6hvr7TAk/8FEFM5SDLO07tebEh
         HwLoT2aea91+J4Qnn1gY9Bhb22LjV40rqcpJVOyqJqBkNViFH6nBFMx0Q1lc+Msodx0u
         4P3V6fU01q39dcwzenf8FiJwDzMOXrlR4BN+DJNFGuC/VDvLptDdihwiZbPluXGkgxy4
         Zav50tnGRaneWD+cCbAQClgUv+RUYJ3PD3BN2B9Et+cOH8zgna4p1+W+l9Z6HjW5n0Aa
         mkOQ==
X-Forwarded-Encrypted: i=1; AHgh+Rr3NlSawW4qR+6OGjXXAi58Tel/vTW5tBidJdgRpf2p5ePaD46bU/DPVTimaiD865i9Jpn0ZvqtIeghNA==@vger.kernel.org
X-Gm-Message-State: AOJu0YygyaSouWBxSafo3EL5+TeUq71U6Qj+AUbUk1NXiFj0Rlxv/dxG
	19rvTpI6uXbmFhECd6m/O2gARbSRcUgy5tKvm8vh/ozm/vkQ4Bpan45jxYyW2g==
X-Gm-Gg: AfdE7cl+rlL4lupzES2ykWQ8dwcL9HFH2giZ7pmUwh5c63s/mlmUMi3NFFVHDVaSqUP
	1fvu/fF8CUqjyFlKzGkDy78MXFh5u+GPdQMEQjUKzsS6AyfGajzJh4ZF/SWFZLX/+RPuonsEfxV
	YuaQ1lcJoQQ7n8HszZcHak+GKepztDulhzFkQoAC/6IBm0J+bIIgpwNqSx/1wKCNjp8j3lS5CkM
	IGuoa/N014fi1+nF/h91u4hKQDSa6ITk1e0nTb9sG14dnJsgMaO7nd0cudhRlqw8EbmbwefMbIg
	drszEkk3GL2RGJh370j1+MzV3XfkhQoi5JAFc+QZjkagmBkx/qlCh+O9SA57jTHjWvUx3uRypWH
	/Rvx26fwkfWMymghFiFdMk3Ti3osyBz+i5p88i5NbQVqP3K9Vj2gqWBBnuHmWfeyK0Kp8Yzj33d
	7fJHsxWBHa0mOEyV83s/s9axqZP+yptkVqU2icwtIgVdl8EKFnizOKOyBdeRe2k98p
X-Received: by 2002:a05:6a21:6b8b:b0:3bf:a638:4376 with SMTP id adf61e73a8af0-3c08edbbb3amr3958242637.21.1783392984467;
        Mon, 06 Jul 2026 19:56:24 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:d89b:1fdd:a8f2:dbeb])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13b659d8da9sm3468560c88.14.2026.07.06.19.56.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 19:56:23 -0700 (PDT)
Date: Mon, 6 Jul 2026 19:56:20 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Pengpeng Hou <pengpeng@iscas.ac.cn>
Cc: Bryam Vargas <hexlabsecurity@proton.me>, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Input: iforce - validate packet lengths
Message-ID: <akxqGsbyj0l8_VWh@google.com>
References: <20260706092016.78176-1-pengpeng@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260706092016.78176-1-pengpeng@iscas.ac.cn>

Hi Pengpeng,

On Mon, Jul 06, 2026 at 05:20:16PM +0800, Pengpeng Hou wrote:
> iforce_process_packet() decodes several packet formats from a
> variable-length input buffer.
> 
> Add minimum length checks for joystick, wheel and status packets before
> reading their fixed fields.
> 
> Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
> ---
>  drivers/input/joystick/iforce/iforce-packets.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/input/joystick/iforce/iforce-packets.c b/drivers/input/joystick/iforce/iforce-packets.c
> index effa76bfd8f9..54697b252b84 100644
> --- a/drivers/input/joystick/iforce/iforce-packets.c
> +++ b/drivers/input/joystick/iforce/iforce-packets.c
> @@ -155,6 +155,9 @@ void iforce_process_packet(struct iforce *iforce,
>  	switch (packet_id) {
>  
>  	case 0x01:	/* joystick position data */
> +		if (len < 5)
> +			break;

This is not enough. iforce_report_hats_buttons() is called
unconditionally and is referencing data[6].

If we add checks we need to cover all cases.

Thanks.

-- 
Dmitry
