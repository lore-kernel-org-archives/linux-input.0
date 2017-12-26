From: Julia Lawall <Julia.Lawall@lip6.fr>
Subject: [PATCH 0/1] Input: inline macros for MODULE_LICENSE, etc
Date: Tue, 26 Dec 2017 18:05:04 +0100
Message-ID: <1514307905-3486-1-git-send-email-Julia.Lawall@lip6.fr>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-kernel@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, linux-input@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
List-Id: linux-input@vger.kernel.org

Inline macro for MODULE_LICENSE to make the license information easy to
find, eg with grep.  Inline the other module-related macros at the same
time.

The complete semantic patch is as follows: (http://coccinelle.lip6.fr/)

// <smpl>
@q@
declarer name MODULE_LICENSE;
identifier i;
constant c;
position p;
@@

MODULE_LICENSE(c@i@p);

@r depends on q@
declarer name MODULE_AUTHOR, MODULE_DESCRIPTION, MODULE_VERSION;
identifier i;
constant c;
position p;
@@

(
MODULE_AUTHOR(c@i@p);
|
MODULE_DESCRIPTION(c@i@p);
|
MODULE_LICENSE(c@i@p);
|
MODULE_VERSION(c@i@p);
)

@other@
identifier r.i;
position p != r.p;
@@

i@p

@s depends on !other@
identifier r.i;
expression e;
@@

#define i e

@@
identifier r.i;
position r.p;
expression s.e;
@@

(
MODULE_AUTHOR(
- i@p
+ e
 );
|
MODULE_DESCRIPTION(
- i@p
+ e
 );
|
MODULE_LICENSE(
- i@p
+ e
 );
|
MODULE_VERSION(
- i@p
+ e
 );
)

@@
identifier r.i;
expression s.e;
@@

-#define i e
// </smpl>

---

 drivers/input/misc/keyspan_remote.c |    9 +++------
 drivers/input/tablet/acecad.c       |    9 +++------
 drivers/input/tablet/hanwang.c      |   10 +++-------
 drivers/input/tablet/kbtab.c        |    9 +++------
 4 files changed, 12 insertions(+), 25 deletions(-)
