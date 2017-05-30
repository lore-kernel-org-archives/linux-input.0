From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v3] Input: mousedev - fix implicit conversion warning
Date: Mon, 29 May 2017 19:44:13 -0700
Message-ID: <20170530024413.GB32841@dtor-ws>
References: <20170526153427.7830-1-nick.desaulniers@gmail.com>
 <20170526154029.9405-1-nick.desaulniers@gmail.com>
 <20170526170746.GA40877@dtor-ws>
 <20170529192252.jv6wpuzaouykqqgy@lostoracle.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f175.google.com ([209.85.192.175]:36134 "EHLO
        mail-pf0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750797AbdE3CoQ (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Mon, 29 May 2017 22:44:16 -0400
Content-Disposition: inline
In-Reply-To: <20170529192252.jv6wpuzaouykqqgy@lostoracle.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Nick Desaulniers <nick.desaulniers@gmail.com>
Cc: gregkh@linuxfoundation.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Mon, May 29, 2017 at 12:22:52PM -0700, Nick Desaulniers wrote:
> On Fri, May 26, 2017 at 10:07:46AM -0700, Dmitry Torokhov wrote:
> > If you look at the code of this fucntion we really use ps2_data as
> > signed in calculations, and this change would break that. While making
> > ps2_data u8 might be beneficial we'd need to rework mousedev_packet() to
> > use signed temporaries for dx, dy and dz before stufifng them into
> > ps2_data.
> 
> Is your recommendation then to stick with the simple cast as in V1 of
> this patch, or stick with u8 and rework mousedev_packet()?

I think casts are often mysterious, so, unless we'll end up with worse
object code, I'd switch to u8 and temps.

-- 
Dmitry
