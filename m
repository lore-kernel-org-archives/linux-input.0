From: Viresh Kumar <viresh.kumar@st.com>
Subject: Re: [PATCH V2 1/2] Input: of_keymap: Introduce matrix_keypad_of_build_keymap()
Date: Thu, 29 Mar 2012 13:53:53 +0530
Message-ID: <4F741C19.4080703@st.com>
References: <4aba6f2cd9f050f419660555bdb661915c1be9b1.1332826100.git.viresh.kumar@st.com> <4F71E0A6.4080703@wwwdotorg.org> <4F7299D7.4020006@st.com> <4F738261.1060002@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from eu1sys200aog117.obsmtp.com ([207.126.144.143]:54789 "EHLO
	eu1sys200aog117.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751371Ab2C2IZS (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 29 Mar 2012 04:25:18 -0400
In-Reply-To: <4F738261.1060002@wwwdotorg.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Stephen Warren <swarren@wwwdotorg.org>
Cc: "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, spear-devel <spear-devel@list.st.com>, "viresh.linux@gmail.com" <viresh.linux@gmail.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "sr@denx.de" <sr@denx.de>

On 3/29/2012 2:58 AM, Stephen Warren wrote:
> so the DT parsing can easily overflow this, and is driven by
> user-supplied data.

Got it. This check is must.

> I think you'll need to pass input_dev->keycodesize

you mean keycodemax here?

> into matrix_keypad_of_build_keymap() to achieve the overall
> range-checking.

Will do that.

> but also checking col against (1<<row_shift) would be
> needed to make sure the individual "fields" of the array index don't
> overflow too.

Ok. Please cross check V3 to verify, i got you comments correctly.

-- 
viresh
