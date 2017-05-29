From: Nick Desaulniers <nick.desaulniers@gmail.com>
Subject: Re: [PATCH v3] Input: mousedev - fix implicit conversion warning
Date: Mon, 29 May 2017 12:22:52 -0700
Message-ID: <20170529192252.jv6wpuzaouykqqgy@lostoracle.net>
References: <20170526153427.7830-1-nick.desaulniers@gmail.com>
 <20170526154029.9405-1-nick.desaulniers@gmail.com>
 <20170526170746.GA40877@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f180.google.com ([209.85.192.180]:36197 "EHLO
        mail-pf0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750886AbdE2TW4 (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Mon, 29 May 2017 15:22:56 -0400
Content-Disposition: inline
In-Reply-To: <20170526170746.GA40877@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: gregkh@linuxfoundation.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Fri, May 26, 2017 at 10:07:46AM -0700, Dmitry Torokhov wrote:
> If you look at the code of this fucntion we really use ps2_data as
> signed in calculations, and this change would break that. While making
> ps2_data u8 might be beneficial we'd need to rework mousedev_packet() to
> use signed temporaries for dx, dy and dz before stufifng them into
> ps2_data.

Is your recommendation then to stick with the simple cast as in V1 of
this patch, or stick with u8 and rework mousedev_packet()?
