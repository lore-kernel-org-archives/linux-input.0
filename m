From: Heiko =?iso-8859-1?q?St=FCbner?= <heiko@sntech.de>
Subject: Re: [PATCH -next] Input: zforce - fix error return code in zforce_start()
Date: Tue, 17 Dec 2013 16:06:49 +0100
Message-ID: <201312171606.49401.heiko@sntech.de>
References: <CAPgLHd8WBR38qd9VHfazXVTbuoJ=GPOafHzSz8d9XJ-F61a7nQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from gloria.sntech.de ([95.129.55.99]:35443 "EHLO gloria.sntech.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753871Ab3LQPGx (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 17 Dec 2013 10:06:53 -0500
In-Reply-To: <CAPgLHd8WBR38qd9VHfazXVTbuoJ=GPOafHzSz8d9XJ-F61a7nQ@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Wei Yongjun <weiyj.lk@gmail.com>
Cc: dmitry.torokhov@gmail.com, rydberg@euromail.se, yongjun_wei@trendmicro.com.cn, linux-input@vger.kernel.org

Am Dienstag, 17. Dezember 2013, 04:27:16 schrieb Wei Yongjun:
> From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
> 
> The error code was not set if unable to set config, so the error
> condition wasn't reflected in the return value. Fix to return a
> negative error code from the error handling case instead of 0.
> 
> Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

Thanks for the catch.

Acked-by: Heiko Stuebner <heiko@sntech.de>
