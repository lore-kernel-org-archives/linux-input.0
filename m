From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH] HID: roccat: Drop cast
Date: Thu, 26 Jun 2014 10:38:06 -0700
Message-ID: <1403804286.7977.58.camel@joe-AO725>
References: <20140626172852.GA2878@himangi-Dell>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20140626172852.GA2878@himangi-Dell>
Sender: linux-kernel-owner@vger.kernel.org
To: Himangi Saraogi <himangi774@gmail.com>
Cc: Stefan Achatz <erazor_de@users.sourceforge.net>, Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, julia.lawall@lip6.fr
List-Id: linux-input@vger.kernel.org

On Thu, 2014-06-26 at 22:58 +0530, Himangi Saraogi wrote:
> This patch removes the cast on data of type void* as it is not needed.

Hi Himangi

The cast of a const void * to a void * was odd.

Maybe a mechanism to verify appropriateness of
loss of constness for any pointer might be useful.
