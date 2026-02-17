Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBB92296BD7
	for <linux-input@vger.kernel.org>; Tue, 17 Feb 2026 18:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771351644; cv=none; b=duYoz9EYx1QhL9uifd3RRasYQEsRe9PIrAf0NCFIirVrAKsv9tYzgEBmy/fPsorspv3QGX781A6vNHa3+AdWLIEtvdPCipJ2CvxQQnKDhX9kFREj/eMFz8umwqsr0VcL7Pg8IsXVK4sQFbb1gabtyKc+jXtsiOzkBizZnJk3qfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771351644; c=relaxed/simple;
	bh=GU2ZsMLrZ0498atJI98z1dJ1CrBAMV2w3hHInE1fuLU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XjtkhbMM6Mg2sLcR5T7m/lYAOEHO3Y4KQIi0nVJjkuAUHXgAT6npSHLem/DQWZXlXLHGSLITLvW53i10H4GdoZT88ncTTMTxwCn/DYM/XNCLuSSoEdG4jssUt5Z5AXu7OaR1KyDctpmg6uZjtTt+IXdOd6mw0YZz/kxEvBgbPkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mQu5whlT; arc=none smtp.client-ip=74.125.82.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mQu5whlT"
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-2ba94dbf739so4632693eec.1
        for <linux-input@vger.kernel.org>; Tue, 17 Feb 2026 10:07:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771351643; x=1771956443; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=I+pGSnrf/FQL2m3dgbUjqs4XmJ24t+sGnnFvB46KXcg=;
        b=mQu5whlT3qAWRThr724oIDALTBTNJpnSlb46ejCrK38THjERJ3I9RdtBKFoGrWgdT/
         RANJB2hDPWVBTrka0588kyv1v8OPaZNIkahigsWz1NrLGAAJ8ObS5j7nJRy2xN92b8WC
         2eCQTBJz+cXqUdODTDqdrFHNpwG8/xNGEslSAVjQ+8RX/JUoPNSQ+uRutP5OC2HGa4QH
         yt0frvkKZaezZ784Vd36ZIl/4h638D2A6c+8+l7pzXPeicV1R8skPBGwi4Wf2WSvGKza
         PTDHviD+YHNYcvOfEruYL96GM2aNYVVkDMNoVDW+OO9a3xNWirGC7uSm7o1ody/zrqns
         oGUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771351643; x=1771956443;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I+pGSnrf/FQL2m3dgbUjqs4XmJ24t+sGnnFvB46KXcg=;
        b=t1hGeviETGQY/10HGcj5GpgIM7uFyVm+JRCHdQ28WohDXom2TndoRJ+9vpSvQ8m2OR
         /hWAJBWVmB+GspM7cKaZsc6T6CwfrxnHuz+ptdx+HrF9shK9/rXsWYfWoBq7GN7aSY47
         9LrHqkZNxpvMUQ4kTw9NqAFJz+aPOYWjEc6qbHQ18/qu7vtRQxf8K3Xt/WQVaYtN2zg6
         DEDqwEbkG9ePNbzoYh450G+/MC6e3rzueCCWp41qAKUehwO73QGjyPJYedqPZFRkOMkC
         ZKmMCbEN9OtVZQVKRaB03voQOmuKm29K5lEKPDgiqoUrnX83qpInmOJtKjZuxG30boet
         at/Q==
X-Gm-Message-State: AOJu0YwrCAq1edny6Grd9mQqIA85zubPghlHvhXOtFPIojEQBivVE4oo
	YnuWsAI7/vI9XPBJrr2Y/qsoAqAD0nSmFjlVIqQjSI8UwfFyUQyP2kz3
X-Gm-Gg: AZuq6aK44viERPG2Hev2eSh1E9NOBTJK4h7L9LGMrEZeH23dwU3wwmHNuxwWV/zyWF1
	ZQFUrsFrs3IRahiK9hOjNU/BOYI9ODwtEablm3m1hqaObirYfUDT+d2UQceM930aTKv1LP9WMc5
	cKB/aZlivos1Ky2Z+aYlP59nXX+63xrs06QDO9DKkwEXA4X4+lr9zoaCmp2YIZTNFuhaev/o1et
	aVZwCrpoVAR6ObJvoRvtNyWh8+WCvWZWE9iXpQ/h9o09FUJSrwXUCA45bwJbZbPeoW6muahqfI4
	2Ov0f1Z7R4UhVw7puQvmjb1lQehluSF88FCpNmcAVU4Ms2Z2CMBa10wjqA+vBAKzTWIA1as/gZC
	JreAawTsZ5rFKMt4aX66Aom6uR25lHzJPQ94Q8Xv3HeOqRSt0Bre2S4ru4bq8FXkmrFlmSGoVVJ
	acFbcqliZ9BuUAVAHboeFBXhTx9wJoZTHND4WrGUNPrvZFBV87Bojijt00uQGQzWPE
X-Received: by 2002:a05:7300:fb83:b0:2ba:77a2:2589 with SMTP id 5a478bee46e88-2babc45568bmr7011683eec.25.1771351642807;
        Tue, 17 Feb 2026 10:07:22 -0800 (PST)
Received: from google.com ([2a00:79e0:2ebe:8:968c:f102:3683:408a])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2bacb543d40sm18181541eec.2.2026.02.17.10.07.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Feb 2026 10:07:22 -0800 (PST)
Date: Tue, 17 Feb 2026 10:07:19 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Max Brener <linmaxi@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Input: libps2 - embed WARN_ON(1) macros into their
 enclosing if statements
Message-ID: <aZSuUomaNQpEs9CN@google.com>
References: <20260214203725.6463-1-linmaxi@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260214203725.6463-1-linmaxi@gmail.com>

On Sat, Feb 14, 2026 at 10:37:24PM +0200, Max Brener wrote:
> Make WARN_ON(1) statements embedded inside their respective 'if' expressions,
> to improve code clarity.
> 
> Signed-off-by: Max Brener <linmaxi@gmail.com>

Applied, thank you.

-- 
Dmitry
