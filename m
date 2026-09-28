Received: from mail-dl2-f39.google.com (mail-dl2-f39.google.com [74.125.229.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE0CA359A9B
	for <linux-input@vger.kernel.org>; Mon, 28 Sep 2026 04:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.167
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790571578; cv=none; b=fVoC7yqlmZECH4adgCsmbD6dMGn4tLfL5zY7bjgw1APLl+acM59+3kN77pQ95TNQHXkaPfaIaSwJH1+papusrjugrdd2YmtJcqKpf2RA/hOMadioBMUYOhEtvHrTeZSHtv1PXzahCvdPhC1sVsW9NZ94olzSbXcr0mtdBc++770=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790571578; c=relaxed/simple;
	bh=61PPvdvT7+epHesKm0vIS/XSxlkq/cKwWq9ySqqAr8o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AjEgKR+2tKc/ruYt9XFm8MMfQlbUN+vaW5nmtceVcgTdZG0PUMgwNDPKoFTydaSffN7ujJ1S+EDko6YrF6bTRm3k7tgX03FYc6sp5s1hJMS6+rOzy+v3Vxuxpoj4esCIaxI1Pg6MYZrY4jsHDvZRecn+Npw0tgf+FQp/OZWdN9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WaF8DjpO; arc=none smtp.client-ip=74.125.229.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WaF8DjpO"
Received: by mail-dl2-f39.google.com with SMTP id a92af1059eb24-1438cb9b3a3so1397980c88.2
        for <linux-input@vger.kernel.org>; Sun, 27 Sep 2026 21:59:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790571576; x=1791176376; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ZGCRwmu4nwdSVpRiSt4vXcO4h9OOTzPPyYo/LlZg0Uo=;
        b=WaF8DjpO/xyfkIIQv5Wo1SM2//ZItfLPshMpZ3oPs8UxfZDsMUYIp/j7MoT9Dn1SGp
         8INCwZ4qsBkqjNcS9xxeTsIJu/9kz0sG0H0vzZManjgRuH0HJiitLu8YG46Pu92sNzWJ
         vkbFBEETMFSHY11gEvo9fMjMkegS63awT68s3O+45LmAoBHINpa5N0VeINVRE3cZUQXg
         sKHKtUxqGZohx908JhwadcxCJ0XhyREFl7TS3D5I1KpmCimiiD5mlctRIG7AHeFHk0cF
         P6ePIv5p8QjwovhQ+Szbk5M9435Kbc+Z7jgFWQClEnMvaz9Wz5ApqGFvesBAoskNHGxC
         uEpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790571576; x=1791176376;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=ZGCRwmu4nwdSVpRiSt4vXcO4h9OOTzPPyYo/LlZg0Uo=;
        b=m4aQswMkzwuiQFpMK2MocaPi00WKOevONBJPJQWGyizUYIMzX7zE+3kBb/GiRvlXH4
         GZSchdXsYI0il9jp3zj1BuWd5+8qDHkfgHnrGWQ9e7rjtAxGT121UAO8XHP20xxYMgDx
         3k2SXZOtcmoffPJArdsyHVzvgBeuBlCMxhl7mFO/SIuvp2L66AsYpM18DLWaVhLA/o7R
         35IfY7rUvKmuSMTlL89opYnEQohT6HJ77xg8cIuC+gfvtP+VMHQkAJpDyO1oZdYoFAFY
         cnC/QBigespCQ3J4woMd2NHUEinv+XEI+kJuZbcrc1qBdmAPezEtRpcCNFPEZlDuSyxd
         E7AQ==
X-Gm-Message-State: AFuF++m7YhDgJ+MphtKZA2EWxUaT2o4fda5MiusbHAvI9ZY1zsJY06WC
	IqzadWv7t/8hBI5Mjkaa0thW91EnEA2Oa2Q7PCO0YZ6dqNvuAiX7a4xr/CyWMuk6
X-Gm-Gg: AYBFou2uTLLvGl90PMXZY5Q9mEhgsiK6Il6gU5XfGj0eWRPCTAi9UsEEtufLAFaukRz
	xkBIlHjocgq4b9X+YGhj38oIK9EZjmHuFamYOPoEHu15nQDuuDEoJCUPfW+9z1HpOhqKIWarHBV
	nm7ASIViTVAkE+Sa5Gn/9zNX4hjjtb+13qwfQIeGxl6lj75xwwwqhV2repEwDMcPLae+eTUd7lg
	iIRmxZLjRoDsUIFH3n9G0oTaRB40oQtYYACBo0BysDSaamMWsLHvkjj7TgDRRxBBJw0urgSt7i7
	55Sw2uJwyHTRke2+wzsrFTEPg5rlhQ7sZiIsx1QPVAqmU4JnfA3olsIjc+v6K6oWAzWNvcixZYb
	T1TaH0eu7pgYXhdsnvECRKKddFuq2U+9QoRQ0My8Nn4ELHuscKXTBTcVUF85OndCLiaAG21I828
	B37ajRuORuiS9Kqig97ct7ma6Aria09nLQKTiSyhtz4py/1qUwHEOq7XF8/zWnG1rdrNWrVx6iH
	dlNKRf77qX3K35SexJaiOf+v4YS7pQVjms423vQ
X-Received: by 2002:a05:7022:5f1a:b0:143:6ef8:862 with SMTP id a92af1059eb24-146ce778270mr8382322c88.11.1790571575896;
        Sun, 27 Sep 2026 21:59:35 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:526d:2f94:503b:aada])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-145ad4028a9sm19108251c88.11.2026.09.27.21.59.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Sep 2026 21:59:35 -0700 (PDT)
Date: Sun, 27 Sep 2026 21:59:32 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: "R. Larocque" <rlarocque@disroot.org>
Cc: linux-input@vger.kernel.org, dave.wang@emc.com.tw, 
	jingle.wu@emc.com.tw, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH V2] Input: elan_i2c_smbus - resend ENABLE_TP on wake
 from sleep (NOT TESTED, NEEDS TESTER!) (v2: typo fixes)
Message-ID: <arnz0y8oqHJTx__b@google.com>
References: <20260922233549.10431-1-rlarocque@disroot.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260922233549.10431-1-rlarocque@disroot.org>

Hi Raphaël,

On Tue, Sep 22, 2026 at 07:35:47PM -0400, R. Larocque wrote:
> From: "Raphaël Larocque" <rlarocque@disroot.org>
> 
> elan_smbus_sleep_control() sends ETP_SMBUS_SLEEP_CMD to put the
> controller to sleep, but does nothing on wake, leaving a long-standing
> XXX comment questioning whether ETP_SMBUS_ENABLE_TP should be re-sent.
> 
> elan_initialize() already treats sleep_control(client, false) as a
> genuine "wake device up" primitive (see the ASUS special-firmware
> branch and its accompanying dev_err() message), so this makes the
> non-ASUS/default path resend ETP_SMBUS_ENABLE_TP symmetrically with
> elan_smbus_initialize() instead of being a no-op.
> 
> Signed-off-by: Raphaël Larocque <rlarocque@disroot.org>
> ---
> RFC: I don't have the Elan SMBus protocol datasheet and consequently 
> haven't been able to test this on any real hardware where the previous no-op
> path was actually relied upon. Sending this for testing by
> someone with access to affected devices before it is considered for
> merge. A bad SMBus write to a sleeping controller could leave it
> in a weird state on the wrong firmware revision if unlucky.

I do not have objections in principle, but this really needs testing on
real hardware... 

Thanks.

-- 
Dmitry
