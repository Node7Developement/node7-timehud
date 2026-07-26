# NODE7 Recipe Installation

Copy `node7-timehud` into the server resources directory and add:

```cfg
ensure node7-timehud
```

Start it after the active RedM time/weather synchronization resource so the HUD reads that synchronized RDR2 world clock.
