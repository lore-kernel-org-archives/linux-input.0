From: Nick Dyer <nick.dyer@itdev.co.uk>
Subject: Re: [PATCH 2/9] Input: atmel_mxt_ts - use deep sleep mode when stopped
Date: Thu, 06 Aug 2015 14:04:15 +0100
Message-ID: <55C35B4F.2000006@itdev.co.uk>
References: <1438615397-17112-1-git-send-email-nick.dyer@itdev.co.uk> <1438615397-17112-3-git-send-email-nick.dyer@itdev.co.uk> <20150805000212.GB20765@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from kdh-gw.itdev.co.uk ([89.21.227.133]:47188 "EHLO
	hermes.kdh.itdev.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755140AbbHFNEQ (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 6 Aug 2015 09:04:16 -0400
In-Reply-To: <20150805000212.GB20765@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, Alan Bowens <Alan.Bowens@atmel.com>



On 05/08/15 01:02, Dmitry Torokhov wrote:
> Since the T9 code is for compatibility with old Pixel only I do not think
> we should be adding it to device tree binding, at least not at the
> moment. I cut the device tree parsing out and default to deep sleep on
> DT-based systems. Thanks. 

That sounds fair enough. We do need something like this eventually to
support different suspend implementations (eg powering down via regulators).
