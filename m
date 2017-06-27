From: Nick Desaulniers <nick.desaulniers@gmail.com>
Subject: Re: [PATCH v4] Input: mousedev - fix implicit conversion warning
Date: Mon, 26 Jun 2017 18:39:42 -0700
Message-ID: <20170627013942.5yr5peskvhfa3rht@lostoracle.net>
References: <20170526154029.9405-1-nick.desaulniers@gmail.com>
 <20170530054151.16639-1-nick.desaulniers@gmail.com>
 <20170625180609.GA8697@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170625180609.GA8697@dtor-ws>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Sun, Jun 25, 2017 at 11:06:09AM -0700, Dmitry Torokhov wrote:
> Hi Nick,
>
> Since the time the code was written we got nice helpers to clamp the
> values. Does the following work for you or it still leaves clang
> unhappy?

LGTM, no more warnings with Clang.
