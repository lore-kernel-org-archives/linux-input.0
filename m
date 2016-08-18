From: Marcos Paulo de Souza <marcos.souza.org@gmail.com>
Subject: Re: [PATCHv3 0/2] Skip selftest on Asus laptops
Date: Thu, 18 Aug 2016 16:46:24 -0300
Message-ID: <20160818194624.GA23003@xfiles>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qk0-f196.google.com ([209.85.220.196]:34511 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754345AbcHSERW (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Fri, 19 Aug 2016 00:17:22 -0400
Received: by mail-qk0-f196.google.com with SMTP id r128so3771608qkc.1
        for <linux-input@vger.kernel.org>; Thu, 18 Aug 2016 21:17:21 -0700 (PDT)
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org

Hi guys,

can you please take a look into these patches?

On Wed, Aug 10, 2016 at 12:26 AM Marcos Paulo de Souza
<marcos.souza.org@gmail.com> wrote:
So, here we are, third version.

Changes since v2:
* Due to the number of devices with problems related to selftest, let's
  disable selftest for any laptop device
  * Fix condition on reset/resume calls of i8042 controller
  Changes since v1:
  * Use reset parameter, instead of adding reset_mode parameter.
  * Change reset parameter from bool to unsigned int.

  Please let me know if I missed something.

  Marcos Paulo de Souza (2):
    kernel-parameters: Update i8042.reset parameter documentation
    input/serio/i8042.c: Skipt selftest on ASUS laptops

  Documentation/kernel-parameters.txt   |  7 ++++++-
  drivers/input/serio/i8042-x86ia64io.h | 21 +++++++++++++++++--
  drivers/input/serio/i8042.c           | 38  +++++++++++++++++++++++++++++------
  3 files changed, 57 insertions(+), 9 deletions(-)
  --
  2.7.4
