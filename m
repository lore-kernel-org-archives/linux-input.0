From: "Bob Copeland" <me@bobcopeland.com>
Subject: Re: 2.6.26-rc3 - appletouch resume "incomplete data package"
Date: Thu, 29 May 2008 22:56:59 -0400
Message-ID: <b6c5339f0805291956j1d39b728n6482003d4b79141b@mail.gmail.com>
References: <b6c5339f0805251324k70a3a56ci9cab5274acc2d01d@mail.gmail.com>
	 <1211800004.17151.51.camel@johannes.berg>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.237]:28896 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751600AbYE3C5C (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 29 May 2008 22:57:02 -0400
Received: by rv-out-0506.google.com with SMTP id l9so4404179rvb.1
        for <linux-input@vger.kernel.org>; Thu, 29 May 2008 19:56:59 -0700 (PDT)
In-Reply-To: <1211800004.17151.51.camel@johannes.berg>
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Johannes Berg <johannes@sipsolutions.net>, oliver@neukum.org
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-input@vger.kernel.org

On Mon, May 26, 2008 at 7:06 AM, Johannes Berg
<johannes@sipsolutions.net> wrote:
> On Sun, 2008-05-25 at 16:24 -0400, Bob Copeland wrote:
>> This appears to be a regression since 2.6.25.  After resuming, I get:
>>
>>     appletouch: incomplete data package (first byte: 2, length: 4).
>>     appletouch: incomplete data package (first byte: 2, length: 4).
>>     appletouch: incomplete data package (first byte: 2, length: 4).

> I have intermittently seen this problem happen for quite a while, a
> bisect will probably not help you.

Hmm, well the console switch in suspend may be triggering it, but I
didn't have the issue in 2.6.25 and it seems to be easily repeatable
for me in .26 so far.  Doing ctrl-alt-f1 to switch to text mode and
back a dozen times didn't break the mouse, but suspending once did.

I tried a bisect anyway but didn't come up with any smoking gun.  Darn.

-- 
Bob Copeland %% www.bobcopeland.com
