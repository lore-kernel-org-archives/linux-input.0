Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795494835;
	b=CppLKB3c8RJX4vCBJU5sgprPJGLFFo/EKWIHKuDH9w7EFMEUnEOu689JH/57z+T7BzJV
	 5wB5qIn/ZrBiEI78Pe32SvP7u4REDrspZf5u7A8fvDCEil6cxsY2dfxIu8HfaoOPdxhif
	 t01nHd9hkNJ0N85dQp45jXvHw5/MCLjNEIFQP+j8Kiskb94BU9JCbdUhozG3XExFw8slF
	 Zf6ruOPjKo2KHkppZAPZwedvzwospSuYb3sIo4ixaDShyBI019ZjWRjklRschRUe+X22s
	 uC4KhDfx5ojysRtUQy9SIyl74yCsghbgZf7fZ+yrN6NM3e62bHbgS2IFkRyqfAQs6+w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795494835;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=NdeN74Wtjt1zICglmVALwnBuGw2TmiMzL+dmKBbx940=;
	b=eKMMIDtIVOsZV7XcDd1YmvtrQww1O7IjAIXe1S27nvPEbuPBGdYz+dMoqrUpjHWeJLCA
	 a29AlF9NgcuJhB0WezJI1MBhMfes7M/aa/UsKuaTApRHAf43UI9aXeOX8qjfAqEbPobMV
	 0Z6MWsYeU3tRDa0v9EerQhTFt4XGPTZAtkwKxjwTayiek7dImsqUwYQLmJ2Kb/p4mzPvC
	 ndskDmT+2h07udlCkAvaobmc7faso5BIMBi72uAll0R+EbU/MsAZ7BQUyGNKzHLJ+WpKU
	 AjW/BDBBM/fyu/UVtqX25jlNceaKCVvhORGrrsbyBTiAEqQ4IK1h8r0nNeNuAFFqs0w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wmCXjJXU;
	arc=none smtp.remote-ip=74.125.82.169
Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2892D606A321
	for <linux-input@vger.kernel.org>; Tue, 24 Nov 2026 04:33:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2892D606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wmCXjJXU
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-3282db206d3so1495964eec.0
        for <linux-input@vger.kernel.org>; Mon, 23 Nov 2026 20:33:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795494834; x=1796099634; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=NdeN74Wtjt1zICglmVALwnBuGw2TmiMzL+dmKBbx940=;
        b=wmCXjJXUvwcD7z+suS3yrxGyGzWuDroHMtSouX6nOGtzzH9jFnmlukGW6JKnfgokN7
         7STFd96S//ZdIxLax1dqPQoGoEq03xM2AGKCprp8amCYNEHQr+QvbpuGuEQEeWrr7EAl
         ZDFEeTsfT0OWcOHPDA0oQSs0z17qcPiHo4/+ilpZFYAqPcW0Iv6N00kpEYBKmHu48Z/H
         x5WR1K1xgylmiqvOPOg+DYwQP0KFcAlGO4ieZlVxWOPfehd6C5ielRjirYDN/HI6nnrY
         AQgHxiqwNQ3vOTPX/N9YxqmLj2DpxCM6Uy2ivhv/xLG/TzpzMcSZPcYPKPtaAG8cCL7p
         ElOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795494834; x=1796099634;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NdeN74Wtjt1zICglmVALwnBuGw2TmiMzL+dmKBbx940=;
        b=N8Zup+sTQj12Mhny4D6ZZ2ZsZyTZWvHQ6YJFnu/1ulZdmS/OpatJ0dYEKPqWtEpdiq
         Wefqso5HLOJ7IvIUqJ1moc5k5I3upvOj98uZyo3cnnpamYaGfPI0/SJoOBDs2mqj3ohC
         q4iPZOlK7mcCaMlZHxKJeaK3AIAk5EQx4uVKAx9hTN3H/sVTGn7g9fXwKHjkbw/7EuUH
         3eGhWkMlQUNQAcyLxqAXxWJCPEHXfzagv5wXRVgt4msf520yNnSf1x6kp/b8Xo6iTSHz
         Lb9/xSMHIg4hhTO+XEzXLZXoAL7K7kncYIa77nZBJ8DDfMArKOQp/8aZ2qoCnEOcK6kT
         7tng==
X-Forwarded-Encrypted: i=1; AL+hErH664fV69owUlqU6QoH40E8OtlabO31ean9QkozxJFMn3qF9ikZLAKlKljOeIWAmgMQy+qKayL+ULq2XA==@vger.kernel.org
X-Gm-Message-State: APuU4Z+CF/kBgmZWalSSSbV0VyCwf1jAfx6WXXYlzvuh1r6DTcmhQPJk
	P2dHbDVYOCwuKjvDh1jkWsEfuYlEd+L0UjhTR7mbHkLzv/F8hlfkOn3j+XTtrv5X
X-Gm-Gg: AZFdTZfrxc1Ys95xDo/9SDy5paXsCIe9JZqQfsGRTqaBSSiS170NjpTZFpzgGohK36O
	agcnp+L/zkY2SfQPls9FL+akNkyj0T81w4XSBU0vu0UGspMOn5hLQ5parG3/XJvJ6pJEAZ3vgwR
	XuGb9FuQkbjyHmxFlrLknH6B7NgWwFGXpr4psUrhF8U/qylcU9Ww0dJlRzEqLNdJp7E2wyPkB+2
	7Ds8DUrR7VtuUGtZcqy6VOLoHBymTnNXp0TOHpEqdd2n8eObgVRZ0zceiyXfXVHmwmIzH6b5HWa
	qhsTZZPW6XNjFu3AfCag3RirAbaGX3C6UycB3x8/NUazLF/bTBNb0uMG5D/e/gev72EkvmCqZpX
	jtZVT+FzjXB2SesH8qhpcrZ+0jjnarAteqog1FUepC00i/WpgNvBMLfHXesouvQw412UkMPlVTd
	NdrUhFceHLlx2DGuOqRbYv6J88MXivz/gn7C+rHBxcjJ65f8Q8RoiVoQpeXeJfLUvmI90RDd5og
	0nI/RWYVs/lPot+SgWbCT6l97YSB9N6FuF8LOEmSkz3s47mt+ETjZOtWKIjTE1BYYPGZLg0JNy3
	d3KR+4/FBXIgTszkjTOB6gbzSgI3S1iHCVAxyxuAH9iYvO/KTcFss4N1jDhbMLtoWvBZICQhNJ2
	eu0L4mwvdQ0dHvFUR
X-Received: by 2002:a05:693c:8083:b0:377:678:2309 with SMTP id 5a478bee46e88-3856ef47a98mr14810166eec.15.1795494834149;
        Mon, 23 Nov 2026 20:33:54 -0800 (PST)
Received: from google.com ([2a00:79e0:2ebe:8:4121:d698:201c:9274])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-38566cd46c5sm49123329eec.11.2026.11.23.20.33.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 20:33:53 -0800 (PST)
Date: Mon, 23 Nov 2026 20:33:50 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Lee Jones <lee@kernel.org>
Cc: Benjamin Tissoires <bentiss@kernel.org>, 
	Andrew Duggan <aduggan@synaptics.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Subject: Re: [PATCH 06/10] Input: synaptics-rmi4 - check for NULL drvdata in
 rmi_set_attn_data()
Message-ID: <awUTq0-QyArghEiT@google.com>
References: <20261123183200.3900004-1-lee@kernel.org>
 <20261123183200.3900004-7-lee@kernel.org>
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
In-Reply-To: <20261123183200.3900004-7-lee@kernel.org>

On Mon, Nov 23, 2026 at 06:31:12PM +0000, Lee Jones wrote:
> Transport drivers such as hid-rmi remain registered and continue
> delivering attention reports via rmi_set_attn_data() even if the
> physical RMI driver failed to probe rmi_dev or was unbound via sysfs.
> 
> When rmi_dev is unbound, dev_get_drvdata(&rmi_dev->dev) returns NULL and
> rmi_set_attn_data() dereferences drvdata->enabled in interrupt context.
> 
> Check that drvdata is non-NULL before accessing drvdata->enabled,
> matching rmi_process_interrupt_requests(), rmi_driver_suspend(), and
> rmi_driver_resume().
> 
> Fixes: b908d3cd812a ("Input: synaptics-rmi4 - allow to add attention data")
> Closes: https://sashiko.dev/#/bug/linux-0165ea80-0dcb-4d48-96cf-e2c1532199a0
> Cc: stable@vger.kernel.org
> Signed-off-by: Lee Jones <lee@kernel.org>

Applied, thank you.

-- 
Dmitry
