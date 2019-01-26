From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [bug report] Input: add st-keyscan driver
Date: Sat, 26 Jan 2019 14:15:12 -0800
Message-ID: <CAKdAkRT6hKywKW1NnD-hiuFn9YTZF74GZVr36ZNJqyoxQghT9Q@mail.gmail.com>
References: <20190122185351.GA28627@kadam> <CAPo_4QB+ozVESD85d2qxuitgvgPgLvrjx9SyEMfFTGvkz4MjWg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAPo_4QB+ozVESD85d2qxuitgvgPgLvrjx9SyEMfFTGvkz4MjWg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ken Sloat <ken.sloat@ohmlinxelectronics.com>
Cc: Dan Carpenter <dan.carpenter@oracle.com>, linux-input <linux-input@vger.kernel.org>, Gabriel FERNANDEZ <gabriel.fernandez@st.com>, lkml <linux-kernel@vger.kernel.org>, Nate Drude <nate.drude@ohmlinxelectronics.com>
List-Id: linux-input@vger.kernel.org

On Sat, Jan 26, 2019 at 1:25 PM Ken Sloat
<ken.sloat@ohmlinxelectronics.com> wrote:
>
> On Tue, Jan 22, 2019 at 1:53 PM Dan Carpenter <dan.carpenter@oracle.com> wrote:
> >
> > Hello Gabriel FERNANDEZ,
>
> Hello Dan,
>
> I have added CCs for the maintainers as well as Gabriel Fernandez as
> currently you just have the linux-input mailing list
>
> > The patch 062589b13991: "Input: add st-keyscan driver" from Apr 12,
> > 2014, leads to the following static checker warning:
> >
> >         drivers/input/keyboard/st-keyscan.c:156 keyscan_probe()
> >         error: potential zalloc NULL dereference: 'keypad_data->input_dev'
> >
> > drivers/input/keyboard/st-keyscan.c
> >     125 static int keyscan_probe(struct platform_device *pdev)
> >     126 {
> >     127         struct st_keyscan *keypad_data;
> >     128         struct input_dev *input_dev;
> >     129         struct resource *res;
> >     130         int error;
> >     131
> >     132         if (!pdev->dev.of_node) {
> >     133                 dev_err(&pdev->dev, "no DT data present\n");
> >     134                 return -EINVAL;
> >     135         }
> >     136
> >     137         keypad_data = devm_kzalloc(&pdev->dev, sizeof(*keypad_data),
> >     138                                    GFP_KERNEL);
> >     139         if (!keypad_data)
> >     140                 return -ENOMEM;
> >     141
> >     142         input_dev = devm_input_allocate_device(&pdev->dev);
> >     143         if (!input_dev) {
> >     144                 dev_err(&pdev->dev, "failed to allocate the input device\n");
> >     145                 return -ENOMEM;
> >     146         }
> >     147
> >     148         input_dev->name = pdev->name;
> >     149         input_dev->phys = "keyscan-keys/input0";
> >     150         input_dev->dev.parent = &pdev->dev;
> >     151         input_dev->open = keyscan_open;
> >     152         input_dev->close = keyscan_close;
> >     153
> >     154         input_dev->id.bustype = BUS_HOST;
> >     155
> > --> 156         error = keypad_matrix_key_parse_dt(keypad_data);
> >                                                    ^^^^^^^^^^^
> I agree with you this would be a problem
> to clarify the NULL derefence would occur here within keypad_matrix_key_parse_dt
>
> struct device *dev = keypad_data->input_dev->dev.parent;
>
> > This assumes we have set "keypad_data->input_dev = input_dev;" but we
> > don't do that until...
> >
> >     157         if (error)
> >     158                 return error;
> >     159
> >     160         error = matrix_keypad_build_keymap(NULL, NULL,
> >     161                                            keypad_data->n_rows,
> >     162                                            keypad_data->n_cols,
> >     163                                            NULL, input_dev);
> >     164         if (error) {
> >     165                 dev_err(&pdev->dev, "failed to build keymap\n");
> >     166                 return error;
> >     167         }
> >     168
> >     169         input_set_drvdata(input_dev, keypad_data);
> >     170
> >     171         keypad_data->input_dev = input_dev;
> >                 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> >
> > this line here.  This driver has never worked and it was included almost
> > five years ago.  Is it worth fixing?
> >
> >     172
> >     173         res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> >     174         keypad_data->base = devm_ioremap_resource(&pdev->dev, res);
> >     175         if (IS_ERR(keypad_data->base))
> >     176                 return PTR_ERR(keypad_data->base);
> >     177
> >
> > regards,
> > dan carpenter
> >
>
> Here is the interesting thing, I was looking on patchwork, and several
> of the patches including what appears to be the latest actually set
> "keypad_data->input_dev = input_dev" before calling
> "keypad_matrix_key_parse_dt"
>
> From v4 on patchwork
> + if (IS_ERR(keypad_data->clk)) {
> + dev_err(&pdev->dev, "cannot get clock");
> + return PTR_ERR(keypad_data->clk);
> + }
> +
> + keypad_data->input_dev = input_dev;
> +
> + input_dev->name = pdev->name;
> + input_dev->phys = "keyscan-keys/input0";
> + input_dev->dev.parent = &pdev->dev;
> + input_dev->open = keyscan_open;
> + input_dev->close = keyscan_close;
> +
> + input_dev->id.bustype = BUS_HOST;
> +
> + error = keypad_matrix_key_parse_dt(keypad_data);
>
> According to patchwork, these aren't listed as accepted, so I'm not
> sure where the exact accepted patch came from. Looking at the commit
> log, it looks like the issue you showed above was made in the original
> commit 062589b1399176a9c14bc68e16169f40439d658c so I'm not quite sure
> what is going on here. Maybe the maintainer can chime in with the
> original patch/mailing list discussion on this. For reference, I've
> added the patchwork links below
> https://patchwork.kernel.org/patch/3854341/
> https://patchwork.kernel.org/patch/3968891/
> https://patchwork.kernel.org/patch/3969991/

It may very well be that I messed up when applying the patch. I guess
whatever platform that is using the driver has not attempted to update
their kernel since then.

Thanks.

-- 
Dmitry
