From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v2 10/17] input/joystick/analog: Switch from rdtscl() to native_read_tsc()
Date: Tue, 16 Jun 2015 16:15:56 -0700
Message-ID: <324F73B8-9C5B-44EC-A7D7-DC27D63FAE07@gmail.com>
References: <cover.1434152603.git.luto@kernel.org> <0c3efbd7b70f76c5dea1d6a9958566cd5fb4a4da.1434152603.git.luto@kernel.org> <20150616230357.GC17610@dtor-ws> <CALCETrX0_et6my95dQ8CgRPWDPPvikFVNAOCW153nAKe17SkqA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f44.google.com ([209.85.220.44]:36764 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751994AbbFPXQF (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 16 Jun 2015 19:16:05 -0400
In-Reply-To: <CALCETrX0_et6my95dQ8CgRPWDPPvikFVNAOCW153nAKe17SkqA@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Andy Lutomirski <luto@amacapital.net>
Cc: Andy Lutomirski <luto@kernel.org>, X86 ML <x86@kernel.org>, Borislav Petkov <bp@suse.de>, Peter Zijlstra <peterz@infradead.org>, John Stultz <john.stultz@linaro.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Len Brown <lenb@kernel.org>, Huang Rui <ray.huang@amd.com>, Denys Vlasenko <dvlasenk@redhat.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

On June 16, 2015 4:09:06 PM PDT, Andy Lutomirski <luto@amacapital.net> wrote:
>Is it okay for -tip to take this and the other one you just acked?

Yeah, that's fine.


Thanks.

-- 
Dmitry
