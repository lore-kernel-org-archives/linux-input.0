From: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
Subject: Unknown ALPS touchpad
Date: Mon, 20 Feb 2017 16:51:08 +0100
Message-ID: <20170220155108.GC20408@pali>
References: <20170219131634.GA7453@riseup.net>
 <20170219133521.GA22927@pali>
 <76481654aedb6b687b145441283f3268@riseup.net>
 <20170219230105.GB11968@xfiles.domain.name>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wr0-f196.google.com ([209.85.128.196]:36080 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752666AbdBTPvL (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Mon, 20 Feb 2017 10:51:11 -0500
Content-Disposition: inline
In-Reply-To: <20170219230105.GB11968@xfiles.domain.name>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Marcos Paulo de Souza <marcos.souza.org@gmail.com>, Masaki Ota <masaki.ota@jp.alps.com>
Cc: John Preston <wcerfgba@riseup.net>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

Adding Masaki into discussion.

On Sunday 19 February 2017 20:01:07 Marcos Paulo de Souza wrote:
> There are other open bugs mentioning the same problem, with similar ALPS devices:
> https://bugzilla.kernel.org/show_bug.cgi?id=57841

Unknown ALPS touchpad: E7=73 03 50, EC=73 02 02

> https://bugzilla.kernel.org/show_bug.cgi?id=43931

Unknown ALPS touchpad: E7=73 00 14, EC=10 00 64

Should be supported since commit 95f75e91 which was introduced in Linux
version v3.13-rc4.

> https://bugzilla.kernel.org/show_bug.cgi?id=80181

Unknown ALPS touchpad: E7=73 03 0a, EC=88 b3 22

> https://bugzilla.kernel.org/show_bug.cgi?id=67941

Unknown ALPS touchpad: E7=73 03 0a, EC=88 b3 18

> This one without even a dmesg output:
> https://bugzilla.kernel.org/show_bug.cgi?id=84081

Sorry, this one does not contain any useful information.

> Maybe they are related, or  also need some touch to let them being discovered as proper devices?

Masaki, can you look at those unknown ALPS touchpad identifiers and
provide some information about protocol which they are using?

Basically touchpads with these identifiers are unsupported by last
kernel version:

E7=73 03 50, EC=73 02 02
E7=73 03 0a, EC=88 b3 22
E7=73 03 0a, EC=88 b3 18

-- 
Pali Rohár
pali.rohar@gmail.com
