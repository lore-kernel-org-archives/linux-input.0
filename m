From: Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>
Subject: Re: [PATCH v2] Input: keyboard - add device tree bindings for simple
 key matrixes
Date: Thu, 29 Dec 2011 13:33:10 -0800
Message-ID: <CAOesGMh6dzy64H8Ex4u72uQt9NvnzVHuWxE5AwWL2ubxPm=zaw@mail.gmail.com>
References: <1325112771-31941-1-git-send-email-olof@lixom.net>
 <1325184146-3527-1-git-send-email-olof@lixom.net>
 <4EFCD846.40901@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <4EFCD846.40901-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
To: Rob Herring <robherring2-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rakesh Iyer <riyer-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-input@vger.kernel.org

On Thu, Dec 29, 2011 at 1:14 PM, Rob Herring <robherring2-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> On 12/29/2011 12:42 PM, Olof Johansson wrote:
>> This adds a simple device tree binding for simple key matrix data.
>>
>> Changes since v1:
>> =A0* Removed samsung-style binding support
>> =A0* Added linux,fn-keymap and linux,fn-key optional properties
>>
>> Signed-off-by: Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>
>> ---
>> =A0.../devicetree/bindings/input/matrix-keymap.txt =A0 =A0| =A0 25 ++++++
>> =A0drivers/input/keyboard/Makefile =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0| =A0 =A01 +
>> =A0drivers/input/keyboard/keymap.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0| =A0 78 ++++++++++++++++++++
>> =A0include/linux/input/matrix_keypad.h =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =
=A0 34 +++++----
>> =A04 files changed, 123 insertions(+), 15 deletions(-)
>> =A0create mode 100644 Documentation/devicetree/bindings/input/matrix-key=
map.txt
>> =A0create mode 100644 drivers/input/keyboard/keymap.c
>>
>> diff --git a/Documentation/devicetree/bindings/input/matrix-keymap.txt b=
/Documentation/devicetree/bindings/input/matrix-keymap.txt
>> new file mode 100644
>> index 0000000..480ca46
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/input/matrix-keymap.txt
>> @@ -0,0 +1,25 @@
>> +For matrix keyboards there are two kinds of layout bindings using
>> +linux key codes.
>
> Need to update this.

Oops, yes.

>> +
>> +Required properties:
>> +- compatible: "matrix-keyboard-controller"
>> +- linux,keymap: an array of 3-cell entries containing the equivalent
>> + =A0of the three separate properties above: row, column and linux
>> + =A0key-code.
>> +
>
> How about just embedding the row/column information as the array
> position in the keymap? Then you only need 1 cell per key. Sparsely
> populated matrices are probably the exception. If more than 1/3 of the
> keys are present, you come out ahead in terms of data usage. You would
> need to specify the number of rows and columns, but that is probably
> easier than determining the max from the keymap.

Actually, in the case of the default layout for tegra-kbc, there are
109 keys defined in a 8*31 (248) matrix, and linux,fn-keymap is going
to be much sparser than that.

Instead, how about packing the row, column and index into one cell as
8, 8, 16 bits? That would be a win for both sparse and dense maps.

Number of rows and columns for the keyboard could be provided as
properties (num-rows, num-columns), it's something I've gone back and
forth in whether it should be in the generic binding or something that
is specific per keyboard vendor -- some of them are hardcoded so
providing properties might not add value.


-Olof
