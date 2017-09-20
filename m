From: Kai-Heng Feng <kai.heng.feng@canonical.com>
Subject: Re: MT_CLS_WIN_8_DUAL on non-trackpoint Alps touchpad
Date: Wed, 20 Sep 2017 10:58:33 +0800
Message-ID: <CAAd53p4UMxyJsxoeMB4-wU4WUHJdn96cAgw4s9OQ+3yjJucZpw@mail.gmail.com>
References: <CAAd53p4dxncEhoPnxOHc40KMCnT6VM=J+oQ0GbZU_Rhm2cKyZw@mail.gmail.com>
 <KAWPR01MB1092AB030876B6186C0E6840C7610@KAWPR01MB1092.jpnprd01.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:48483 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751544AbdITC6g (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Tue, 19 Sep 2017 22:58:36 -0400
Received: from mail-oi0-f70.google.com ([209.85.218.70])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1duVDf-0007o0-HW
        for linux-input@vger.kernel.org; Wed, 20 Sep 2017 02:58:35 +0000
Received: by mail-oi0-f70.google.com with SMTP id p126so894860oih.2
        for <linux-input@vger.kernel.org>; Tue, 19 Sep 2017 19:58:35 -0700 (PDT)
In-Reply-To: <KAWPR01MB1092AB030876B6186C0E6840C7610@KAWPR01MB1092.jpnprd01.prod.outlook.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Masaki Ota <masaki.ota@jp.alps.com>, Jiri Kosina <jikos@kernel.org>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

On Wed, Sep 20, 2017 at 10:39 AM, Masaki Ota <masaki.ota@jp.alps.com> wrote:
> Hi, Kai,
>
> Basically, 0x120A device does not have a trackpoint.
> ALPS has released 0x120A device + trackpoint as a sample for DELL, but it does not exist as Mass production. (We changed PTP Dual device Product ID to 0x121F, 0x1220 from 0x120A.)

Yes, it's on a Dell laptop ;)
Thank you for your clarification.

> And we are not going to release 0x120A dual device to the market in the future.

Hi Jiri,
Based on the comment from Masaki, can we revert commit
fcaa4a07d2a4b541e91da7a55d8b3331f96d1865?

Thanks!

>
> Best Regards,
> Masaki Ota
> -----Original Message-----
> From: Kai-Heng Feng [mailto:kai.heng.feng@canonical.com]
> Sent: Wednesday, September 20, 2017 11:18 AM
> To: 太田 真喜 Masaki Ota <masaki.ota@jp.alps.com>; linux-input@vger.kernel.org
> Subject: MT_CLS_WIN_8_DUAL on non-trackpoint Alps touchpad
>
> Hi Masaki,
>
> Support for ALPS 0x120A trackpad got added in patch [1].
>
> The problem is, there are two versions of 0x120A, one comes with a trackpoint, one does not.
>
> Since there's ".export_all_inputs = true" for the device, the trackpoint will be incorrectly reported by hid-multitouch for the non-trackpoint version.
> Now userspace tools think the touchpad has a trackpoint, which is incorrect here.
>
> So is there a way to address the issue?
>
> [1] https://marc.info/?l=linux-kernel&m=150235885718077&w=2
