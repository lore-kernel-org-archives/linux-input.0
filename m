Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49BB034C145
	for <linux-input@vger.kernel.org>; Tue, 24 Feb 2026 22:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771973156; cv=none; b=usqfL68zY/7do4X4H6WBPbvujVpFfb2yccZ6/I6Q/sLea3mLSVnA602seem3e79WHB/SMjcsDksJZ9M5z2wJABkbSOOdeh6skoqEeU+clelPPu+mtapxAPDuPV5QVmWOCY9X/fbPIPv9YrZ2cSRFOHWaRhJDwmraDpnUY1Q+v5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771973156; c=relaxed/simple;
	bh=TYBiyejN0jz0+b/rgo7kDkzVulDkERlKSoX28q5x02c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LkQa5mM3XM7xviL98B+ctjYbhl8Swiq2bn0+UIAILGmbM/1NG+B6vqqEjYgFLPv/XvnIbwy4zP60simrBNclhrf9JehOkJjScCaac/E0iJE1qNrLkIhETQq5ztqBkCcFLZx6tqsGn2RV9rlYOG276UeN6M931lcZqSb0fmwJJmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k//6xXNL; arc=none smtp.client-ip=74.125.82.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k//6xXNL"
Received: by mail-dl1-f54.google.com with SMTP id a92af1059eb24-12776bebe9fso1371672c88.1
        for <linux-input@vger.kernel.org>; Tue, 24 Feb 2026 14:45:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771973154; x=1772577954; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=e2wPLOGaHE2wd2tfpX30LfpnZoC91AB69pgJ3FbTup0=;
        b=k//6xXNLzoZbvfkKhJ3SBo0klkStq3XzRs7mBGOf3Pl7Z8oIhW7jCwFW9kDQB4tEYc
         oJyM9rZMM+wzKDVlfwykaeG+YJSAlSLRZZBOz6CzMKkmkWoswGC1RZlqtJaXYmVjjLdw
         zeqD7vobYEx9UsT7ZJSIr051VEHusd7tk63NqAmTgGhbHPDpcuyp8EY7VdRAwJ+JOv4V
         zPa00if1XX9MNIP6GgoOHE1mzdvNkiGAKkGs0bhv5HBxmgpLzOj0UWibHLcxQpF2pCuP
         QQl0Ylz+Q9gWbWlz0uXqsm2E8u78cQ4WOfKaXHT6MVrFPYZQQKqirdsHNoMCOyK5tenb
         suBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771973154; x=1772577954;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e2wPLOGaHE2wd2tfpX30LfpnZoC91AB69pgJ3FbTup0=;
        b=maSeg9u3/IdGHSOHrwgT2FpFoGKhkvhfADBHspCkZBmGoYJKT0tPFU5PQkBvoOyc7w
         03ZTszfRLJ5msZso+mKS23Nov6GF36a9H6oerbn3L9utEXqnKAyZvIAan3dHV4otE2Nu
         hEfn2veKF54Fpfuk/GXsMaXV/7BrNBTUplIczYS8nF4Vr29eH1NhLPPpZ2MlW/lKVoSz
         187ZN5f0L/eI74ESn6AvgrIf/ZnrMdSm1X6sx1M1I+GLGuhWEDfFKb7eeObXtXw3M1M5
         ONYmmtdShbOxS1Fj+tU9Q3/cEZ5Tb+LEwHOz9k7bp4QGKOjl19K/bN7mzGI1a2RTQ3/F
         4ZOA==
X-Gm-Message-State: AOJu0Yza2AHPX46YwQ0wLvIeLHjiIqH/ywOexE3KjDZ6dHPZnUf+gKIV
	oeaX8SCGgCkwL7/F+i/mmTQB0p+kW8quQOujCxIi1pkvXRsplOxeejGm
X-Gm-Gg: ATEYQzyXpnNX4OheyvEDdiiNqs6jJShNLaH38Y1nq9QpxTGWl1lKBvIoyAOJ4VwPrKt
	6dXNBpNIZKV+2sxVrokwxlGLV+5gLqer1y3jxUlnfXx5aMXM1U+/FY6ti0E8O0jAngDCLTtXHT0
	baDXgpWCQf/E3vO62aqsm+9/FxLhwpm9s5oWfDTJXkahjOTYpSR9giIq/Xph1Y1tGloyu6jTs5S
	VbWgdeaW4TQOp6AR/tELSVRvy8EnzIVhGyzb3oVh/4arRBBOzVWN2xDgz37KUu/a5Yb0gYczZX8
	Vm2xV+dMuROlHf8NXVqe+E0soJk25IKcXj5Xy4eVo3OHWZvBC2YWzcM+8hmVgK/cKUMyRGAhS2o
	bPlg/GoR24mjkMcyUT3Fv0J/F1BqtgeG5b5IqppCCCprwukD0VhHplynZ7juDvZUBAlAUga2lFS
	lB8KtBd7eUe+k5CgiTJAuqSrqkrerkANh68w6LsNaKPC5iOVsDu1QfrKbdyA4b6xUl
X-Received: by 2002:a05:7300:1904:b0:2ba:8018:cc53 with SMTP id 5a478bee46e88-2bdc34136d2mr51884eec.35.1771973154321;
        Tue, 24 Feb 2026 14:45:54 -0800 (PST)
Received: from google.com ([2a00:79e0:2ebe:8:e1d3:e70f:c61b:7501])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2bdbc90844csm1165762eec.26.2026.02.24.14.45.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Feb 2026 14:45:53 -0800 (PST)
Date: Tue, 24 Feb 2026 14:45:51 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Yauhen Kharuzhy <jekhor@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Hans de Goede <hansg@kernel.org>
Subject: Re: [PATCH v2 4/5] input: drv260x: Fix unbalanced
 regulator_disable() call
Message-ID: <aZ4qB-bw4olcPKSD@google.com>
References: <20260215141435.727872-1-jekhor@gmail.com>
 <20260215141435.727872-5-jekhor@gmail.com>
 <aZZ4jqZQZ4vA1SFO@google.com>
 <aZbg2w2lIahy_sM9@jekhomev>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aZbg2w2lIahy_sM9@jekhomev>

On Thu, Feb 19, 2026 at 12:11:47PM +0200, Yauhen Kharuzhy wrote:
> On Wed, Feb 18, 2026 at 06:43:30PM -0800, Dmitry Torokhov wrote:
> > Hi Yauhen,
> > 
> > On Sun, Feb 15, 2026 at 04:14:34PM +0200, Yauhen Kharuzhy wrote:
> > > +static void drv260x_remove(struct i2c_client *client)
> > > +{
> > > +	struct drv260x_data *haptics = i2c_get_clientdata(client);
> > > +
> > > +	regulator_disable(haptics->regulator);
> > >  }
> > 
> > This will result in power being shut off the first thing during
> > unbinding, which is too early.
> > 
> > I switched this to devm_add_action_or_reset() and applied.
> 
> Do you mean that, in this case, regulator_disable() may be called before any
> devm_* registered actions? Good point, thanks.
> 

Yes, all devm* actions are run after remove() completes.

Thanks.

-- 
Dmitry
