Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B55AB5616A4
	for <linux-input@vger.kernel.org>; Wed, 14 Oct 2026 17:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792000427; cv=none; b=slxvo7RNByKp33MV61eq/nuSpw3dIRyTKN7u4v2dFJkpwcUwY0gsgrAZtwk1KxvBodCJRhvSeR4ZT03RG/MddjrKz5PZl0Wm6FzvHGMDUmrt42Q8A4avxGuzbwqJ6naE+rR7uPqWUTlyZ+hQKcSsSJan9tvihnGFl6Xeqp+3Isk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792000427; c=relaxed/simple;
	bh=hRr229Cr95OY2+JJl0EtUncc2+R6eOJ16mUx8MHqb7I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qbzUqOXw/90Tu5Hlm+YLefzNI4Dht6ys5fyytGglqNNLaWpqMqMI4GrnC9iyvEXuJDjQ4P/QuV8++NEqGZCfioZb9Q2pZtPtw7GZhLjAkYfuLF4j2n4ZMnkHsfrxeFz4EwNSKWkxeOYfANbF6Yyn1QiuIyNa3yDMBx7dGZQSpv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=neQoRlXO; arc=none smtp.client-ip=74.125.82.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="neQoRlXO"
Received: by mail-dl1-f52.google.com with SMTP id a92af1059eb24-17bc533fda3so1330203c88.1
        for <linux-input@vger.kernel.org>; Wed, 14 Oct 2026 10:53:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792000426; x=1792605226; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=kLj64hTBXBolUSqkfxopLToY/0ejR9Fisko65Xwg5ts=;
        b=neQoRlXOvlBcgllroAbMqUVlS5sbLAm+qNxLL14jdSG5PWPIstSrotDygeq5ITHlOb
         mO1MCPFqkHiv0yatMQWb5dcc3RiLW6xlNtbiZ+COo1Yhi0znBqdPorfOBd6SqFp0q9vX
         GJxV922wdl2+wtRGTxgQQS/FwJHDUvoTOKN6xuhieI2I7Ieng7DV13zbTXRh9LJ3Nvqd
         0fhDPcBo0/7NBfb6A/1y5Rh+G0hwRCV37M6wRearMoe0howmBwNc80gaTbM9/8598aNT
         1CLWS07qT3u5b9EZG+j7pi4vlgXf3rwc7LUzJ/XZqrTEt1VzQkQGV1dkyAmAwlWVGLwi
         Brnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792000426; x=1792605226;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kLj64hTBXBolUSqkfxopLToY/0ejR9Fisko65Xwg5ts=;
        b=PVODAYR0MYfd8rD7dyo1FN1D+ZzMIfgPKsaqyqsakSA74nzjNomKW6cAQqeCBHWRE/
         Om1mIJRoVROUo38eLNOLUF4+RlpZQgR4++27JYLt4qxt7SyTEnGhOHRK7lo2CSA40oOf
         vOFSfLIl9cK+fC4YAJvYNDxTgLtwfttslN5wEMQbiQFYd245S+I4AaX+UZnm6OqYGzVy
         4kwuU+JAvv4cReYe/r0A0NlcVSsEIB/+sukC5yF19+JWXlCt8bUuxA17uSzpbdsNEopV
         D2cvif2W94hgEwvvSt9Vzj2O7BeETCv9qjvkeSujkNPTenoEm7pXxJQh9eYW1xf03rBm
         zIlA==
X-Gm-Message-State: AFq9FYIJ3q7EQOJI0xUByz795snDLzixXtvdLceqVF9UkbsOh4m4vD7P
	FkiN1pvT/J7oDP6Kakfl0NeBafbwca/7IpEgQz4rlHmsXtML7/0zstVbkElwiiLn
X-Gm-Gg: AYBFou2U6IYh9SwbCH6IDSsqoxUhGrqjlqG2wdJJrAn/9MJGjcIO+V0EqxMOURYNSTg
	EUaan8u7MEpqmkyKMbXxXYAeH01r8NI1jMMeFH5Ku8Stwz5GsgdOhu+iuvyNpQ7jdV42Gd0PbyU
	Dq4vpDA8PoKakVCZLNDw3O0O92dILCSVmy29MfgH8gcqGt6gfTPVYEWMwqnWzuMzAk2L05Cy2ho
	GszNsfXE5wn3vjRepst4MjAqSWiAVJpbneiumCilPFV/dyU1cq2/fhsS7cfIIyPKvms5AaVWJN0
	Ol5WeUyRAEVXi20w1E++6gZo9aodSphJTSa5YiZ9nfONeNoRccKPm8uax6neUQIMCfjpJCtxWOx
	tWcvwKyShrXBjEGClO/xd/jzbwC7XiEuNrsoE87jaqV25KlDyhGhlDphIAXtN9578MIKj7JdTiu
	UrtsI5xR/dvAyhPCSUx27Zv/4crCCAYjCANNQe3xsfVYB8l3jZM07uOmmBy2JVqOc/f9aK/3F11
	ak1RXRSZ5U6q+KKwDgYolLTp91IGiesFi60vFDG
X-Received: by 2002:a05:701b:230c:b0:143:2967:c0b1 with SMTP id a92af1059eb24-16a5fc91121mr22575774c88.25.1792000425485;
        Wed, 14 Oct 2026 10:53:45 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:875a:117f:b9ea:5a08])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-169a1becb11sm45801314c88.4.2026.10.14.10.53.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 10:53:44 -0700 (PDT)
Date: Wed, 14 Oct 2026 10:53:42 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Francesco Orlando <francesco.orlando99@libero.it>
Cc: linux-input@vger.kernel.org
Subject: Re: [PATCH v2] Input: xpad - add GameSir Nova Lite support
Message-ID: <as_BotJs55sgT53O@google.com>
References: <20261011165821.72698-1-francesco.orlando99@libero.it>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261011165821.72698-1-francesco.orlando99@libero.it>

On Sun, Oct 11, 2026 at 06:58:21PM +0200, Francesco Orlando wrote:
>     Add vendor and product ID for GameSir Nova Lite (0x3537:0x1040)
>     in XInput mode to enable force feedback rumble support.
> 
> Signed-off-by: Francesco Orlando <francesco.orlando99@libero.it>

Applied, thank you.

-- 
Dmitry
