From: John <zendhetmij@gmail.com>
Subject: [Bug 84921] Logitech Cordless Rumblepad II navigates up until a button
 is pressed
Date: Sun, 21 Sep 2014 16:53:24 +0200
Message-ID: <541EE664.5030605@gmail.com>
References: <bug-84921-112111@https.bugzilla.kernel.org/> <bug-84921-112111-Gl7DT4RsEZ@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wi0-f169.google.com ([209.85.212.169]:56056 "EHLO
	mail-wi0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751147AbaIUOx1 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 21 Sep 2014 10:53:27 -0400
Received: by mail-wi0-f169.google.com with SMTP id fb4so1609326wid.0
        for <linux-input@vger.kernel.org>; Sun, 21 Sep 2014 07:53:26 -0700 (PDT)
In-Reply-To: <bug-84921-112111-Gl7DT4RsEZ@https.bugzilla.kernel.org/>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: bugzilla-daemon@bugzilla.kernel.org

Hi, I noticed a bug in the drivers of the 'Logitech cordless rumblepad 2' controllers.

When starting SteamOS (debian based) and running steam both my controllers keep navigating up. This disappears when on all connected controllers a button is pressed. Probably because at this moment the controller connects to the receiver and takes over input from the controller. The default settings before getting any controller input seems to be 'navigate up'.

* Expected behaviour
Receiver gives no output to computer until any input from  with controller received

Tested on different setups:
Steam + SteamOS has Bug
Steam + Ubuntu 14.04 has the same bug.
Steam + windows 8 does not give this bug.

Please let me know if there are any questions.


On 21-09-14 16:31, bugzilla-daemon@bugzilla.kernel.org wrote:
> https://bugzilla.kernel.org/show_bug.cgi?id=84921
>
> --- Comment #1 from Greg Kroah-Hartman <greg@kroah.com> ---
> On Sun, Sep 21, 2014 at 01:51:30PM +0000, bugzilla-daemon@bugzilla.kernel.org
> wrote:
>> https://bugzilla.kernel.org/show_bug.cgi?id=84921
>>
>>              Bug ID: 84921
>>             Summary: Logitech Cordless Rumblepad II navigates up until a
>>                      button is pressed
> Please send this to the linux-input@vger.kernel.org mailing list.
>

