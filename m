Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF65C2594B9
	for <linux-input@vger.kernel.org>; Wed, 11 Mar 2026 05:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773205859; cv=none; b=A+cUMFDzGxAXA1AbeOpHf4n3nEuDjNm+tK0mXBZ4h6fQuC6psTsCagiEdtBw7mcR+e7LaUeUazQPbTFFeoANWdbmuFEINt1nnzkzGiqmJ8FGfRndNTSu5rHAENwPUElBW25xxGfmgnLEHaWT9/hjdPg+NeHTkrak58nx2SW9+bU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773205859; c=relaxed/simple;
	bh=OM4qA659h1ZDbIWPqTMqRO8/S3PkK0dlLyNE7bPqJZ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V1kPSb1ocENf/Dq/VHynQDYGo1VEr7uW7y6Em0J6veZICjzvXG2tv63ZHJkDKltnwnbdV98B670AEU084RpJA+Y1ye+RMp5yQcGPGZsdqVWCP+nZ4IQE5Y+OM8ofOA3zEqGcFvxezz7MNTJNrw4dh4Y41Ek4QUMqGjbOSVlq0Q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GKUKrTYE; arc=none smtp.client-ip=74.125.82.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GKUKrTYE"
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-2bd9a485bd6so11050068eec.1
        for <linux-input@vger.kernel.org>; Tue, 10 Mar 2026 22:10:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773205857; x=1773810657; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=E3laUE6i6y3qJpg501FXVY7DCFbmQnP9JAUpAN9WyI0=;
        b=GKUKrTYEqjQdIPgmyYvWEYRBWj3tU/hpD3Nk0rEAO3N+gW3OagHoKuVdrN4JkqepOk
         DBhQdAV02T0TXRjG35ZwjYV/4ptxybnGDZbWFG9THQb2Q8SuRl7Z3tEsJ3AykRKi4hxJ
         q57vQZ+CQf8912pEkeoXrdb8MHSi74LXT28sshqaVshthB2wEdK3+4KIsUmHfp08PVWJ
         cavsoA5UySyUvJNiqPcFkaNgfwaBU/u4gq+oT1+cl5Ro/RQsicVoKXgu/dlj2KeuQJ/F
         oebkBMAza259swq00IPQ7gSld4YoWHguiF9YFyeZNHMbVBfCDBTIDHwJhA9FH13ew7Rh
         P2LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773205857; x=1773810657;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E3laUE6i6y3qJpg501FXVY7DCFbmQnP9JAUpAN9WyI0=;
        b=oiDKnwt8RNWx3M+5Oe9JcBbGHP2rmnNDYw7mFME9caJvk0NvSERFRjpo9gSB1lQruq
         6/bOJz6tQxnuhcHZ3ZWutp9Hv/ePsPMtXLp4/Drfbvb3MbJ6MG1bhAzDGE/uixOG2vCv
         5JeX8jrVCiYYbZjJTuWSbyuTveMth0MdE214UVtVukLSrOt1w7fttjqv4NK9oo4WAdsG
         FmZuabx8OVVccA6G/lCS2bV63WxijpghuIzfi3YVTMA2dxvnphR6eCjXx09ftdgELeHJ
         508Ukql2/2xHPlBnfR+F4mNhxVoVaTvhTZlqKmM/c1LBdtMHy+rQDYilnZ0sydF497Xa
         I33w==
X-Forwarded-Encrypted: i=1; AJvYcCWCas2iB0exI+AvdzT25EXhaEf1ukDGXgbQSwsz4luoA9/4ZmNtzkBk3p94/oFydqbXbdYZMuEOkMKhlA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzK1m1csNaBYTOPXRws1hy2eIK0dtrjDIplqWwFoxszDxypEHEu
	fKIzaHwOFH1XcNJ7JvqmV0C6QPhnxVZ9cqEUErxNLQznmvYrlTEvfKhA
X-Gm-Gg: ATEYQzw1HFDG+vxhMp/c8jAClqgX67Nh4GBeViL3kQK6U1QONQ0Ucra1tbjDAodGH//
	OqL9iHCu8NfpNtLq9G1cZuTreDR6hH3l2SWFn9hbrkWFeG9TkEu/2Y6zT4icZf8hVXEwEQWTRff
	WXPHWWSQYWTFxqq/xr47HRnYruoUp5JK7s1NELoFzca6xfZD2JlxYr3AzfDSv2MR0wx0OlIpiT9
	J5LM9xXIOVPdiXhf+qQ3QtPF2kSUVqYFOiIzbvyDaK2x/jncSstPU8kGfkuZInYFNZ0QdLuffnx
	ZEKOL5Je1KxY5rWPN8c9FArVeIG4xrbvSRTUQ4cGsj/7i55ximSrK4JX5WoN93ysHFVbD6deYK0
	U3uDpKj9CmbEYSDirtzh92lJscEZdO4nxsyYcxd8c5abPLm5smK7YjsT2GyXiY8TAAJDxjW78IB
	IQopTzwXv0OdeX1O/H+l+AzDwaSxY59KjVXz3Yzi9AhnRz3M1iiTbFUbkn1weWJGOH
X-Received: by 2002:a05:7301:2b05:b0:2ba:7b71:4f4 with SMTP id 5a478bee46e88-2be8a586373mr512287eec.32.1773205856884;
        Tue, 10 Mar 2026 22:10:56 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:6e17:9d84:ffa0:986b])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2be8a8550d5sm1192398eec.12.2026.03.10.22.10.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2026 22:10:56 -0700 (PDT)
Date: Tue, 10 Mar 2026 22:10:53 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Jingyuan Liang <jingyliang@chromium.org>
Cc: Jiri Kosina <jikos@kernel.org>, 
	Benjamin Tissoires <bentiss@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Mark Brown <broonie@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, linux-input@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, hbarnor@chromium.org, Jarrett Schultz <jaschultz@microsoft.com>, 
	Dmitry Antipov <dmanti@microsoft.com>
Subject: Re: [PATCH 01/12] Documentation: Correction in HID output_report
 callback description.
Message-ID: <abD5HV7TeNHtq8hi@google.com>
References: <20260303-send-upstream-v1-0-1515ba218f3d@chromium.org>
 <20260303-send-upstream-v1-1-1515ba218f3d@chromium.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260303-send-upstream-v1-1-1515ba218f3d@chromium.org>

On Tue, Mar 03, 2026 at 06:12:53AM +0000, Jingyuan Liang wrote:
> From: Jarrett Schultz <jaschultz@microsoft.com>
> 
> Originally output_report callback was described as must-be asynchronous,
> but that is not the case in some implementations, namely i2c-hid.
> Correct the documentation to say that it may be asynchronous.
> 
> Signed-off-by: Dmitry Antipov <dmanti@microsoft.com>
> Signed-off-by: Jingyuan Liang <jingyliang@chromium.org>
> ---
>  Documentation/hid/hid-transport.rst | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/hid/hid-transport.rst b/Documentation/hid/hid-transport.rst
> index 6f1692da296c..2008cf432af1 100644
> --- a/Documentation/hid/hid-transport.rst
> +++ b/Documentation/hid/hid-transport.rst
> @@ -327,8 +327,8 @@ The available HID callbacks are:
>  
>     Send raw output report via intr channel. Used by some HID device drivers
>     which require high throughput for outgoing requests on the intr channel. This
> -   must not cause SET_REPORT calls! This must be implemented as asynchronous
> -   output report on the intr channel!
> +   must not cause SET_REPORT calls! This call might be asynchronous, so the
> +   caller should not expect an immediate response!

Reviewed-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Thanks.

-- 
Dmitry
